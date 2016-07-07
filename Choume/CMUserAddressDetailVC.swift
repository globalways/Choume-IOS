//
//  AddressDetailVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/7.
//  Copyright © 2015年 outsouring. All rights reserved.
//
import UIKit

class AddressDetailVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var labelAddressArea: UILabel!
    @IBOutlet weak var textFieldContact: UITextField!
    @IBOutlet weak var textFieldTel: UITextField!
    @IBOutlet weak var textFieldDetail: UITextField!
    
    //address data
    var allDict: NSDictionary = NSDictionary()
    var provinces = [String]()
    var cities    = [String]()
    var states    = [String]()
    
    var currentProvince: String = ""
    var currentCity: String = ""
    var currentState: String  = ""
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem?.title = "保存"
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "saveData"
        self.navigationItem.title = "地址详情"
        
        //加载地址数据文件
        let filePath = NSBundle.mainBundle().pathForResource("AddressData.plist", ofType:nil )
        allDict = NSDictionary(contentsOfFile: filePath!)!
    }
    
    
    override func viewDidLoad() {
        var areaTapRcgnizer = UITapGestureRecognizer(target: self, action: "areaTaped")
        labelAddressArea.userInteractionEnabled = true
        labelAddressArea.addGestureRecognizer(areaTapRcgnizer)
    }
    
    /// 加载三级城市数据: province > city > state
    func initAddressData(){
        
        //设置省
        provinces = allDict.allKeys as! [String]
        currentProvince = provinces[0]
        
        //加载所有二级城市
        for(var i=0;i<allDict.allValues.count; i++){
            cities.appendContentsOf(allDict.allValues[i].allKeys as! [String])
        }
        //默认二级城市根据一级城市设定
        cities.removeAll()
        cities.appendContentsOf(allDict.valueForKey(currentProvince)!.allKeys as! [String])
        currentCity = cities[0]
        
        //加载所有三级城市
        for(var i=0;i<allDict.allValues.count; i++){
            for(var j=0; j<allDict.allValues[i].allKeys.count; j++){
                let tmpArray = allDict.allValues[i].valueForKey(allDict.allValues[i].allKeys[j] as! String) as! [String]
                states.appendContentsOf(tmpArray)
            }
        }
        
        if let tmpArray = allDict.valueForKey(currentProvince)!.valueForKey(currentCity) {
            states.removeAll()
            states.appendContentsOf(tmpArray as! [String])
            //当前三级城市
            currentState = states[0]
        }
    }
    
    func saveData(){
        let name = textFieldContact.text
        if name == ""{
            self.noticeInfo(ADDR_NEED_CONTACT)
            return
        }
        let contact = textFieldTel.text
        if contact == ""{
            self.noticeInfo(ADDR_NEED_TEL)
            return
        }
        let area = labelAddressArea.text
        if area == "点击以选择"{
            self.noticeInfo(ADDR_NEED_AREA)
            return
        }
        let detail = textFieldDetail.text
        if detail == ""{
            self.noticeInfo(ADDR_NEED_DETAIL)
            return
        }
        
        
        
        APIClient.sharedInstance.userNewAddress(CMContext.sharedInstance.getToken(), name: name!, contact: contact, area: area, detail: detail, success: { (json) -> Void in
            
            if json.respStatus() == .OK {
                
                //修改内存数据
                let varUserAddress = UserAddress()
                varUserAddress.name = name
                varUserAddress.contact = contact
                varUserAddress.area = area
                varUserAddress.detail = detail
                CMContext.currentUser?.user?.addrs?.append(varUserAddress)
                
                self.noticeTop(ADDR_NEW_OK)
                self.navigationController?.popViewControllerAnimated(true)
            }else {
                self.noticeError(json.respStatus().description(), autoClear: true, autoClearTime: 2)
            }
            
            }) { (error) -> Void in
                print(error)
        }
        
        
    }
    

    func areaTaped(){
        
        initAddressData()
        
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
        buttonCancel.addTarget(self, action: "cancelSelection:", forControlEvents: UIControlEvents.TouchDown);
        
        
        //add buttons to the view
        let buttonOkFrame: CGRect = CGRectMake(170, 7, 100, 30); //size & position of the button as placed on the toolView
        
        //Create the Select button & set the title
        let buttonOk: UIButton = UIButton(frame: buttonOkFrame);
        buttonOk.setTitle("确定", forState: UIControlState.Normal);
        buttonOk.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonOk); //add to the subview
        buttonOk.addTarget(self, action: "confirmArea:", forControlEvents: UIControlEvents.TouchDown);
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        let picker = UIPickerView()
        
        picker.tag = 100
        picker.delegate = self
        picker.dataSource = self
        
        alertController.view.addSubview(picker)
        alertController.view.addSubview(toolView)
        
    }
    
    func cancelSelection(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func confirmArea(sender: UIButton){
        //print(String(stringInterpolation: currentProvince,currentCity,currentState))
        labelAddressArea.text = String(stringInterpolation: currentProvince,currentCity,currentState)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    
    //datasource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 : return provinces.count
        case 1 : return cities.count
        case 2 : return states.count
        default: return 0
        }
    }
    
    
    //delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0: return provinces[row]
        case 1:return cities[row]
        case 2: return states[row]
        default: return "";
        }
        //return String(stringInterpolation: "r", row.stringValue," c",component.stringValue)
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            currentProvince = provinces[row]
            
            cities.removeAll()
            cities.appendContentsOf(allDict.valueForKey(provinces[row])!.allKeys as! [String])
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
            states.removeAll()
            states.appendContentsOf(allDict.valueForKey(currentProvince)!.valueForKey(cities[0]) as! [String])
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            //当前二三级城市
            currentCity = cities[0]
            currentState = states[0]
            
            break
            
        case 1:
            currentCity = cities[row]
            
            if let tmpArray = allDict.valueForKey(currentProvince)!.valueForKey(cities[row]) {
                states.removeAll()
                states.appendContentsOf(tmpArray as! [String])
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                //当前三级城市
                currentState = states[0]
            }
            
            break
        case 2:
            currentState = states[row]
            break
        default: break;
        }
    }
    
}
