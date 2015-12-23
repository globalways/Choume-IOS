//
//  CMNewProjectVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/10.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit
import SVProgressHUD

class CMNewProjectVC: UIViewController {
    let MS = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stepBtn1: NoHighlightButton!
    @IBOutlet weak var stepBtn2: NoHighlightButton!
    @IBOutlet weak var stepBtn3: NoHighlightButton!
    @IBOutlet weak var stepBtn4: NoHighlightButton!
    
    private var btnArray: [NoHighlightButton]!
    private var scrollView: UIScrollView!
    private var bottomButton: UIButton!
    
    private var tableView1: MainTableView!
    private var selectedCellIndex: Int?
    private var selectedCellSection: Int?
    private var categoryIndex: Int = 0{
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
    private var stepActive: UIImage = UIImage(named: "Icon-Up")!
    private var stepInactive: UIImage = UIImage(named: "Icon-Down")!
    
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
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 135, width: AppWidth, height: AppHeight - 180))
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(scrollView)
        
        bottomButton = UIButton(frame: CGRect(x: 15, y: AppHeight-40, width: AppWidth-30, height: 35))
        bottomButton.setTitle(nextSetpStr, forState: .Normal)
        bottomButton.backgroundColor = theme.CMNavBGColor
        bottomButton.layer.cornerRadius = 5.0
        bottomButton.addTarget(self, action: "nextStepPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(bottomButton)
    }
    
    func setTableViews() {
        tableView1 = MainTableView(frame: CGRectMake(0, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView1.separatorStyle = .SingleLine
        
        tableView2 = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, scrollView.height), style: .Grouped, dataSource: self, delegate: self)
        tableView2.separatorStyle = .SingleLine
        tableView2.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmNameFieldCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmNameFieldCell)
        
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
    
    
    func nextStepPressed(sender: UIButton) {
        
        switch currentStep {
        case 2:
            getTableView2Data()
            break
        case 3:
            getTableView3Data()
            break
        case 4:
            getTableView4Data()
            saveNewProject()
            break
        default:break
        }
        
        if currentStep != 4 {
            currentStep++
        }
        scrollToStep(currentStep)
    }
    
    func scrollToStep(step: Int) {
        scrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(step - 1), 0), animated: true)
    }
    
}

extension CMNewProjectVC {
    func getTableView2Data() {
        let count = tableView2.numberOfRowsInSection(0)
        for index in 0...count {
            if let cell = tableView2.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? CMNameFieldCell {
                switch index {
                case 0:
                    newProject.title = cell.textField.text
                    break
                case 1:
                    newProject.desc = cell.textField.text
                    break
                case 2:
                    newProject.requiredMoneyAmount = UInt64(cell.textField.text!)
                    break
                case 3:
                    newProject.requiredPeopleAmount = UInt64(cell.textField.text!)
                    break
                case 4:
                    newProject.requiredGoodsName = cell.textField.text
                    break
                case 5:
                    newProject.requiredGoodsAmount = UInt64(cell.textField.text!)
                    break
                case 6:
                    newProject.deadline = 23423
                    break
                default:break
                }
            }
        }
    }
    
    func getTableView3Data() {
        newProject.rewards = rewardArray
    }
    
    func getTableView4Data() {
        
    }
    
    func saveNewProject(){
        SVProgressHUD.show()
        let token = CMContext.sharedInstance.getToken()
        APIClient.sharedInstance.raiseCfProject(token, project: newProject, success: { (json) -> Void in
            print(json)
            SVProgressHUD.dismiss()
            }) { (error) -> Void in
                SVProgressHUD.dismiss()
                print(error)
                self.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
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
            if indexPath.row == 0 {
                cell.label.text = "标题"
            }else if indexPath.row == 1 {
                cell.label.text = "描述"
            }else if indexPath.row == 2 {
                cell.label.text = "筹资额"
            }else if indexPath.row == 3 {
                cell.label.text = "人员数量"
            }else if indexPath.row == 4 {
                cell.label.text = "物品"
            }else if indexPath.row == 5 {
                cell.label.text = "物品数量"
            }else if indexPath.row == 6 {
                cell.label.text = "截止日期"
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
                cell.textLabel?.text = "回报方式"+String(indexPath.row+1)
            }
            return cell
        }else if tableView == tableView4 {
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmNameFieldCell) as! CMNameFieldCell
            if indexPath.row == 0 {
                cell.label.text = "联系人"
            }else if indexPath.row == 1 {
                cell.label.text = "联系电话"
            }
            return cell
        }
        return UITableViewCell()
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
            return 8
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
        }
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableView1 {
            if section == 0 {
                return 0.1
            }
        }else if tableView == tableView2 || tableView == tableView3 || tableView == tableView4{
            return 0.1
        }
        return 20
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == tableView1 {
            if section == 1 {
                return "校园合伙人"
            }
        }
        return ""
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == tableView1 {
            if let index = selectedCellIndex {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: selectedCellSection!))
                cell?.accessoryType = .None
            }
            selectedCellIndex = indexPath.row
            selectedCellSection = indexPath.section
            categoryIndex = selectedCellSection!*3 + selectedCellIndex!
            tableView1.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
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
}

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
