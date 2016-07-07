//
//  CMNewProjectVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/10.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit
import SVProgressHUD
import DKImagePickerController
import DLRadioButton
import ObjectMapper

protocol CMNewProjectDetailImagesDelegate {
    func onToSelectImage(collectionView: UICollectionView)
}

class CMNewProjectVC: UIViewController {
    let MS = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    let newProjectSB = UIStoryboard(name: "NewProject", bundle: NSBundle.mainBundle())
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stepBtn1: NoHighlightButton!
    @IBOutlet weak var stepBtn2: NoHighlightButton!
    @IBOutlet weak var stepBtn3: NoHighlightButton!
    @IBOutlet weak var stepBtn4: NoHighlightButton!
    
    //第二步的日期选择器
    var step2DatePicker: UIDatePicker? = nil
    var step2EndDateCell: UITableViewCell?
    
    private var assets: [DKAsset] = []
    private var selectedImages: [UIImage] = [] {
        didSet {
            
        }
    }
    
    
    private let IMAGE_TEXTVIEW_TAG = 111
    private var btnArray: [NoHighlightButton]!
    private var scrollView: UIScrollView!
    /// next step button
    private var bottomButton: UIButton!
    
    private var tableView1: MainTableView!
    private var selectedCellIndex: Int?
    private var selectedCellSection: Int?
    private var categoryIndex: Int = 0 {
        didSet {
            newProject.category = CrowdFundingCategory(rawValue: categoryIndex)
        }
    }
    private var tableView2: MainTableView!
    private var tableView3: MainTableView!
    private var rewardArray: Array<CfProjectReward> = []
    
    
    private var tableView4: MainTableView!
    
    private var nextSetpStr: String  = "下一步"
    private var submitStr: String = "提交"
    private var stepActive: UIImage = UIImage(named: "choose_selected")!
    private var stepInactive: UIImage = UIImage(named: "choose_unselected")!
    
    private var newProject = CfProject()
    
    private var currentStep: Int = 1 {
        didSet{
            if currentStep == 4 {
                bottomButton.setTitle(submitStr, forState: .Normal)
            }else{
                bottomButton.setTitle(nextSetpStr, forState: .Normal)
            }
            
            for index in 1...4 {
                btnArray[index-1].imageView?.image = stepInactive
            }
            btnArray[currentStep-1].imageView?.image = stepActive
        }
    }
    
    override func viewDidLoad() {
        setStepButtons()
        setScrollViewAndButton()
        setTableViews()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationItem.title = "创建项目"
        
        //当返回当前vc时显示当前的offset
        scrollToStep(currentStep)
    }
    
    func setStepButtons() {
        btnArray = [stepBtn1, stepBtn2, stepBtn3, stepBtn4]
        setButtonImageTopLabelBottom(stepBtn1)
        setButtonImageTopLabelBottom(stepBtn2)
        setButtonImageTopLabelBottom(stepBtn3)
        setButtonImageTopLabelBottom(stepBtn4)
    }
    
    func setButtonImageTopLabelBottom(btn: UIButton) {
        btn.centerLabelVerticallyWithPadding(10)
    }
    

    func setScrollViewAndButton() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 135, width: AppWidth, height: AppHeight - 175))
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(scrollView)
        
        bottomButton = UIButton(frame: CGRect(x: 0, y: AppHeight-40, width: AppWidth, height: 40))
        bottomButton.setTitle(nextSetpStr, forState: .Normal)
        bottomButton.backgroundColor = theme.CMNavBGColor
        //bottomButton.layer.cornerRadius = 5.0
        bottomButton.addTarget(self, action: #selector(CMNewProjectVC.nextStepPressed(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(bottomButton)
    }

    /// 四个步骤：选择类别、项目信息、回报方式、审核发布
    func setTableViews() {
        tableView1 = MainTableView(frame: CGRectMake(0, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView1.separatorStyle = .SingleLine
        
        tableView2 = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView2.separatorStyle = .SingleLine
        tableView2.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmNameFieldCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmNameFieldCell)
        tableView2.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmTextImageCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmTextImageCell)
        tableView2.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmFourRadioBtnCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmFourRadioBtnCell)
        
        
        tableView3 = MainTableView(frame: CGRectMake(AppWidth*2, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView3.separatorStyle = .SingleLine
        
        tableView4 = MainTableView(frame: CGRectMake(AppWidth*3, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView4.separatorStyle = .SingleLine
        tableView4.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmNameFieldCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmNameFieldCell)
        
        scrollView.addSubview(tableView1)
        scrollView.addSubview(tableView2)
        scrollView.addSubview(tableView3)
        scrollView.addSubview(tableView4)
    }
    
    // "下一步"按钮触发
    func nextStepPressed(sender: UIButton) {
        
        switch currentStep {
        case 1:
            if newProject.category == nil {
                self.cmAlert("", msg: "请选择一个类别")
                return
            }
            
            break
        case 2:
            if !getTableView2Data() {
                //测试不用步骤2字段验证
                return
            }
            break
        case 3:
            if !getTableView3Data(){
                return
            }
            break
        case 4:
            if !getTableView4Data() {
                return
            }
            saveNewProject()
            break
        default:break
        }
        
        if currentStep != 4 {
            currentStep += 1
        }
        scrollToStep(currentStep)
    }
    
    func scrollToStep(step: Int) {
        scrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(step - 1), 0), animated: true)
    }
    
}

extension CMNewProjectVC {
    /// 获取tableView2数据(项目信息) return true ok
    func getTableView2Data() -> Bool{
        if newProject.title == nil || newProject.title == "" {
            self.cmAlert("", msg: "请输入项目标题")
            return false
        }
        
        if newProject.desc == nil || newProject.desc == "" {
            self.cmAlert("", msg: "请输入项目介绍")
            return false
        }
        
        //物品&数量 同时存在或者同时没有
        if (newProject.requiredGoodsName ?? "").isEmpty != (newProject.requiredGoodsAmount <= 0){
            print(newProject.requiredGoodsAmount)
            self.cmAlert("", msg: "物品名称或数量有误")
            return false
        }
        //出让股份&募资 必须同时存在或者同时没有
        if (newProject.requiredProjectAmount <= 0) != (newProject.requiredProjectEquity <= 0) {
            self.cmAlert("", msg: "融资额或出让股份数目有误")
            return false
        }
        //至少筹集一类东西
        if newProject.requiredMoneyAmount <= 0 && newProject.requiredPeopleAmount <= 0 && newProject.requiredGoodsAmount <= 0 && newProject.requiredProjectEquity <= 0{
            self.cmAlert("", msg: "至少筹集一类")
            return false
        }
        //主要完成指标
        if newProject.majarType == nil {
            self.cmAlert("", msg: "请选择主要完成指标")
            return false
        }
        //截止时间
        if newProject.deadline < Int(NSDate().timeIntervalSince1970){
            self.cmAlert("", msg: "截止时间有误")
            return false
        }
        return true
    }
    
    /// 获取回报方式
    func getTableView3Data() -> Bool{
        newProject.rewards = rewardArray
        if newProject.rewards?.count < 1 {
            self.cmAlert("", msg: "请至少填写一种回报方式")
            return false
        }
        return true
    }
    
    /// 获取tableView4的数据
    func getTableView4Data() -> Bool{
        if (newProject.tel ?? "").isEmpty {
            self.cmAlert("", msg: "请填写项目负责人电话")
            return false
        }
        if (newProject.contact ?? "").isEmpty {
            self.cmAlert("", msg: "请填写项目负责人")
            return false
        }
        return true
    }
    
    func saveNewProject(){
        SVProgressHUD.showProgress(-1, status: "正在上传图片...", maskType: .Black)
        //SVProgressHUD.showProgress(-1, maskType: .Black)
        let token = CMContext.sharedInstance.getToken()!
        var imageDatas:[NSData] = []
        
        // 异步准备图片，上传图片
        for index in 0 ... self.assets.count - 1 {
            self.assets[index].fetchOriginalImage(false, completeBlock: { (image, info) in
                if image == nil {
                    print(info)
                }else{
                    if let tmpData = UIImageJPEGRepresentation(image!, 1.0) {
                        imageDatas.append(tmpData)
                    }
                }
                
                if index == self.assets.count - 1 && imageDatas.count == self.assets.count{
                    //准备项目信息
                    APIClient.sharedInstance.uploadImage(token, imageDatas: imageDatas, success: { (strs) in
                        var projectPics = [CfProjectPic]()
                        for url in strs {
                            projectPics.append(CfProjectPic(url: url))
                        }
                        self.newProject.pics = projectPics
                        SVProgressHUD.showProgress(-1, status: "正在保存项目信息...", maskType: .Black)
                        
                        APIClient.sharedInstance.raiseCfProject(token, project: self.newProject, success: { (json) -> Void in
                            SVProgressHUD.dismiss()
                            if json.respStatus() == .OK {
                                SVProgressHUD.showSuccessWithStatus("创建项目成功，等待审核", maskType: .Black)
                                Tool.uiHalfSec(NSDate(), completion: {
                                    self.navigationController?.popViewControllerAnimated(true)
                                })
                            }else {
                                print(json)
                                SVProgressHUD.showErrorWithStatus("创建项目失败\n" + json.respMsg(), maskType: .Black)
                            }
                            
                        }) { (error) -> Void in
                            SVProgressHUD.dismiss()
                            self.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
                        }

                    }) { (error) in
                        // upload image error
                        print(error)
                    }
                }else if index == self.assets.count - 1 && imageDatas.count != self.assets.count{
                    SVProgressHUD.showErrorWithStatus("获取图片信息错误",maskType: .Black)
                }
            })
            
        }
        
        
        
        
        
    }
}

extension CMNewProjectVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView1 == tableView {
            let cell: UITableViewCell = UITableViewCell()
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.textLabel?.text = "筹乐子"
                cell.textLabel?.textColor = theme.CMGray333333
            }
            if indexPath.section == 0 && indexPath.row == 1 {
                cell.textLabel?.text = "筹票子"
                cell.textLabel?.textColor = theme.CMGray333333
            }
            if indexPath.section == 0 && indexPath.row == 2 {
                cell.textLabel?.text = "筹爱心"
                cell.textLabel?.textColor = theme.CMGray333333
            }
            if indexPath.section == 1 && indexPath.row == 0 {
                cell.textLabel?.text = "项目类"
                cell.textLabel?.textColor = theme.CMGray333333
            }
            if indexPath.section == 1 && indexPath.row == 1 {
                cell.textLabel?.text = "产品类"
                cell.textLabel?.textColor = theme.CMGray333333
            }
            cell.tintColor = theme.CMNavBGColor
            return cell
        }else if tableView == tableView2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmNameFieldCell) as! CMNameFieldCell
            let textImageCell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmTextImageCell) as! CMTextImageCell
            textImageCell.tag = IMAGE_TEXTVIEW_TAG
            //选择图片回调
            textImageCell.delegate = self
            
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    cell.label.text = "标题"
                    cell.textField.borderStyle = .None
                    cell.textField.placeholder = "项目的标题"
                    cell.textField.textAlignment = .Right
                    cell.textField.addTarget(self, action: #selector(CMNewProjectVC.titleTextFieldChange(_:)), forControlEvents: .EditingChanged)
                }else if indexPath.row == 1 {
                    textImageCell.tvIntroduction.delegate = self
                    return textImageCell
                }
                break
            case 1:
                if indexPath.row == 0 {
                    let cell1 = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                    cell1.accessoryType = .DisclosureIndicator
                    cell1.textLabel?.text = "筹资金"
                    return cell1
                }else if indexPath.row == 1 {
                    let cell1 = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                    cell1.accessoryType = .DisclosureIndicator
                    cell1.textLabel?.text = "筹集人员"
                    return cell1
                }else if indexPath.row == 2 {
                    let cell1 = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                    cell1.accessoryType = .DisclosureIndicator
                    cell1.textLabel?.text = "筹集物品"
                    return cell1
                }else if indexPath.row == 3 {
                    let cell1 = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                    cell1.accessoryType = .DisclosureIndicator
                    cell1.textLabel?.text = "合伙人招募"
                    return cell1
                }
                break
                
            case 2:
                if indexPath.row == 0 {
                    //
                    let cellTmp = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmFourRadioBtnCell) as! CMFourRadioBtnCell
                    cellTmp.delegate = self
                    return cellTmp
                }else if indexPath.row == 1 {
                    step2EndDateCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                    step2EndDateCell!.accessoryType = .DisclosureIndicator
                    step2EndDateCell!.textLabel?.text = "截止日期"
                    step2EndDateCell!.detailTextLabel?.text = "选择"
                    return step2EndDateCell!
                }
            default:
                break
            }
            return cell
        }else if tableView == tableView3 {
            let cell = UITableViewCell()
            cell.accessoryType = .DisclosureIndicator
            if indexPath.row == rewardArray.count {
                cell.textLabel?.textColor = theme.CMNavBGColor
                cell.textLabel?.text = "添加回报方式"
            } else {
                cell.textLabel?.textColor = theme.CMGray333333
                cell.textLabel?.text = rewardArray[indexPath.row].desc
            }
            return cell
        }else if tableView == tableView4 {
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmNameFieldCell) as! CMNameFieldCell
            if indexPath.row == 0 {
                cell.label.text = "联系人"
                cell.textField.borderStyle = .None
                cell.textField.placeholder = "张三"
                cell.textField.textAlignment = .Right
                cell.textField.addTarget(self, action: #selector(CMNewProjectVC.contactTextFieldChanged(_:)), forControlEvents: .EditingChanged)
            }else if indexPath.row == 1 {
                cell.label.text = "联系电话"
                cell.textField.keyboardType = .NumberPad
                cell.textField.borderStyle = .None
                cell.textField.placeholder = "手机号"
                cell.textField.textAlignment = .Right
                cell.textField.addTarget(self, action: #selector(CMNewProjectVC.telTextFieldChanged(_:)), forControlEvents: .EditingChanged)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tableView == tableView2) {
            if indexPath.section==0 && indexPath.row == 1 {
                return 200
            }
        }
        return 45
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            if section == 0 {
                return 3
            }
            if section == 1 {
                return 2
            }
        }else if tableView == tableView2 {
            switch section {
            case 0: return 2
            case 1: return 4
            case 2: return 2
            default: return 0
            }
        }else if tableView == tableView3 {
            return rewardArray.count + 1
        }else if tableView == tableView4 {
            return 2
        }
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == tableView1 {
            return 2
        }else if tableView == tableView2 {
           return 3
        }
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        if tableView == tableView1 {
            if section == 0 {
                return 0.1
            }
        }else if tableView == tableView2{
            if section==0 {
                return 0.1
            }
        }
        else if tableView == tableView3 || tableView == tableView4{
            return 0.1
        }
        return 20
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableView1 {
            if section == 1 {
                return "校园合伙人"
            }
        }else if tableView == tableView2 {
            switch section {
            case 1:
                return "你需要筹集什么（至少一种）"; break;
            case 2: return "主要完成指标"
            default:
                return ""
            }
        }
        return ""
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if tableView == tableView1 {
            if let index = selectedCellIndex {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: selectedCellSection!))
                cell?.accessoryType = .None
            }
            selectedCellIndex = indexPath.row
            selectedCellSection = indexPath.section
            categoryIndex = selectedCellSection!*3 + selectedCellIndex! + 1
            tableView1.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        }else if tableView == tableView2 {
            if indexPath.section == 1 {
                switch indexPath.row {
                case 0:
                    let step2MoneyTC: Step2MoneyTC = newProjectSB.instantiateViewControllerWithIdentifier(NewProjectSB.step2MoneyTC) as! Step2MoneyTC
                    step2MoneyTC.delegate = self
                    //set default money
                    //if let tmpMoney = newProject.requiredMoneyAmount {
                        step2MoneyTC.defaultMoney = String(newProject.requiredMoneyAmount / 100)
                    //}
                    self.navigationController?.showViewController(step2MoneyTC, sender: nil)
                    break
                case 1:
                    let step2PeopleTC: Step2PeopleTC = newProjectSB.instantiateViewControllerWithIdentifier(NewProjectSB.step2PeopleTC) as! Step2PeopleTC
                    step2PeopleTC.delegate = self
                    self.navigationController?.showViewController(step2PeopleTC, sender: nil)
                    
                    //if let tmpPeopleAmount = newProject.requiredPeopleAmount {
                        step2PeopleTC.defaultPeopleAmount = String(newProject.requiredPeopleAmount)
                    //}
                    
                    break
                case 2:
                    let step2GoodsTC: Step2GoodsTC = newProjectSB.instantiateViewControllerWithIdentifier(NewProjectSB.step2GoodsTC) as! Step2GoodsTC
                    step2GoodsTC.delegate = self
                    if let tmpGoodsName = newProject.requiredGoodsName {
                        step2GoodsTC.defaultGoodsName = tmpGoodsName
                    }
                    
                    //if let tmpGoodsAmount = newProject.requiredGoodsAmount {
                        step2GoodsTC.defaultGoodsAmount = String(newProject.requiredGoodsAmount)
                    //}
                    
                    self.navigationController?.showViewController(step2GoodsTC, sender: nil)
                    break
                case 3:
                    let step2PartnerTC: Step2PartnerTC = newProjectSB.instantiateViewControllerWithIdentifier(NewProjectSB.step2PartnerTC) as! Step2PartnerTC
                    step2PartnerTC.delegate = self
                    if let tmpPartnerMoney = newProject.requiredProjectAmount {
                        step2PartnerTC.defaultParterMoney = String(tmpPartnerMoney / 100)
                    }
                    if let tmpPartnerEquity = newProject.requiredProjectEquity {
                        step2PartnerTC.defaultParterEquity = String(tmpPartnerEquity)
                    }
                    self.navigationController?.showViewController(step2PartnerTC, sender: nil)
                    break
                default:
                    break
                }
                
            }else if indexPath.section == 2 && indexPath.row == 1{
                showDatePicker()
            }
        }
        
        if tableView == tableView3 {
            let vc = MS.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmProjectReturnDetailVC) as! CMProjectRewardDetailVC
            vc.delegate = self
            //-1代表新建回报方式
            vc.rewardIndex = -1
            if indexPath.row != rewardArray.count {
                vc.currentReward = rewardArray[indexPath.row]
                vc.rewardIndex = indexPath.row
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // 找到image&textview的cell set delegate&datasource
        if cell.tag == IMAGE_TEXTVIEW_TAG {
            let textImageCell = cell as! CMTextImageCell
            textImageCell.setCollectionViewDataSourceDelegate(self)
        }
    }
}

// 项目详情描述图片列表
extension CMNewProjectVC: UICollectionViewDataSource, UICollectionViewDelegate {
    /// DataSource Required
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
    /// DataSource Required
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CellIdentifiers.cmCVImageCell, forIndexPath: indexPath) as! CMCVImageCell
        //cell.ivCellImage.image = selectedImages[indexPath.row]
        let asset = self.assets[indexPath.row]
        asset.fetchImageWithSize(CGSize(width: 60,height: 60), completeBlock: { image, info in
            cell.ivCellImage.image = image
        })
        return cell
    }
}

//回报方式
extension CMNewProjectVC: CMProjectRewardDetailVCDelegate {
    func onSetProjectReward(reward: CfProjectReward, forIndex: Int) {
        if forIndex == -1 {
            rewardArray.append(reward)
        } else {
            rewardArray[forIndex] = reward
        }
        tableView3.reloadData()
    }
}

//项目详情图片
extension CMNewProjectVC: CMNewProjectDetailImagesDelegate {
    func onToSelectImage(collectionView: UICollectionView) {
        let pickerController = DKImagePickerController()
        pickerController.assetType = .AllPhotos
        pickerController.defaultSelectedAssets = self.assets
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets:" + String(assets.count))
            self.assets = assets
            self.selectedImages.removeAll()
            for i in 0 ..< assets.count {
                assets[i].fetchImageWithSize(CGSize(width: 60,height: 60), completeBlock: { (image, info) in
                    self.selectedImages.append(image!)
                })
            }
            collectionView.reloadData()
        }
        
        self.presentViewController(pickerController, animated: true) {}
    
    }
}

//主要完成指标,radiobuttons
extension CMNewProjectVC: FourRadioBtnCellDelegate {
    func onRadioSelected(btn: DLRadioButton) {
        switch btn.tag {
        case 1001:
            newProject.majarType = CfProjectSupportType.MONEY_CFPST
            break;
        case 1002:
            newProject.majarType = CfProjectSupportType.PEOPLE_CFPST
            break;
        case 1003:
            newProject.majarType = CfProjectSupportType.GOODS_CFPST
            break;
        case 1004:
            newProject.majarType = CfProjectSupportType.EQUITY_CFPST
            break;
        default:break
        }
    }
    
    @IBAction func showDatePicker(){
        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n",
                                                preferredStyle: UIAlertControllerStyle.ActionSheet)
    
        //Create the toolbar view - the view witch will hold our 2 buttons
        let toolFrame = CGRectMake(17, 5, 270, 45);
        let toolView: UIView = UIView(frame: toolFrame);
        
        //add buttons to the view
        let buttonCancelFrame: CGRect = CGRectMake(0, 7, 100, 30); //size & position of the button as placed on the toolView
        
        //Create the cancel button & set its title
        let buttonCancel: UIButton = UIButton(frame: buttonCancelFrame);
        buttonCancel.setTitle("取消", forState: UIControlState.Normal);
        buttonCancel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonCancel); //add it to the toolView
        
        //Add the target - target, function to call, the event witch will trigger the function call
        buttonCancel.addTarget(self, action: Selector("cancelSelection:"), forControlEvents: UIControlEvents.TouchDown);
        
        
        //add buttons to the view
        let buttonOkFrame: CGRect = CGRectMake(170, 7, 100, 30); //size & position of the button as placed on the toolView
        
        //Create the Select button & set the title
        let buttonOk: UIButton = UIButton(frame: buttonOkFrame);
        buttonOk.setTitle("确定", forState: UIControlState.Normal);
        buttonOk.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonOk); //add to the subview
        buttonOk.addTarget(self, action: Selector("confirmDate:"), forControlEvents: UIControlEvents.TouchDown);
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        step2DatePicker = UIDatePicker()
        step2DatePicker!.tag = 100
        step2DatePicker?.locale = NSLocale(localeIdentifier: "zh_CN")
        step2DatePicker?.datePickerMode = .Date
        alertController.view.addSubview(step2DatePicker!)
        alertController.view.addSubview(toolView)
    }
    
    @IBAction private func cancelSelection(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction private func confirmDate(sender: UIButton){
        newProject.deadline =  Int((step2DatePicker?.date.timeIntervalSince1970)!)
        let formatter = NSDateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        step2EndDateCell?.detailTextLabel?.text = formatter.stringFromDate(step2DatePicker!.date)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

// step2 二级controller返回值  & step4
extension CMNewProjectVC:UITextViewDelegate, Step2MoneyTCDelegate, Step2PeopleTCDelegate, Step2GoodsTCDelegate, Step2PartnerTCDelegate {
    //项目标题
    func titleTextFieldChange(textField: UITextField){
        newProject.title = textField.text
    }
    //项目desc
    func textViewDidChange(textView: UITextView) {
        newProject.desc = textView.text
    }
    
    func onMoneySet(money: Int) {
        let moneyCell = tableView2.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1))
        moneyCell?.detailTextLabel?.text = String(money) + "元"
        //元转分
        newProject.requiredMoneyAmount = money * 100
    }
    
    func onPeopleSet(peopleNum: Int) {
        let cell = tableView2.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1))
        cell?.detailTextLabel?.text = String(peopleNum) + "名"
        newProject.requiredPeopleAmount = peopleNum
    }
    
    func onGoodsSet(goodsName: String, goodsAmount: Int) {
        let cell = tableView2.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1))
        cell?.detailTextLabel?.text = "[" + goodsName + "]" + String(goodsAmount) + "件"
        newProject.requiredGoodsName = goodsName
        newProject.requiredGoodsAmount = goodsAmount
    }
    
    func onPartnerSet(partnerMoney: Int, partnerEquity: Int) {
        let cell = tableView2.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 1))
        cell?.detailTextLabel?.text = "让股" + String(partnerEquity) + "‰募资" + String(partnerMoney) + "元"
        newProject.requiredProjectAmount = partnerMoney * 100
        newProject.requiredProjectEquity = partnerEquity
    }
    
    //tableView4
    func contactTextFieldChanged(textField: UITextField){
        newProject.contact = textField.text
    }
    func telTextFieldChanged(textField: UITextField){
        newProject.tel = textField.text
    }
    
}
