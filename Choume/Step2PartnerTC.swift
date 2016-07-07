//
//  Step2PartnerTC.swift
//  Choume
//
//  Created by wang on 16/4/28.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

protocol Step2PartnerTCDelegate {
    func onPartnerSet(partnerMoney:Int, partnerEquity:Int)
}

class Step2PartnerTC: UITableViewController {
    @IBOutlet weak var tfPartnetMoney: UITextField!
    @IBOutlet weak var tfPartnetEquity: UITextField!
    
    var delegate:Step2PartnerTCDelegate?
    var defaultParterMoney: String = ""
    var defaultParterEquity: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if !defaultParterMoney.isEmpty {
            tfPartnetMoney.text = defaultParterMoney
        }
        if !defaultParterEquity.isEmpty {
            tfPartnetEquity.text = defaultParterEquity
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationItem.title = "合伙人招募"
        self.editButtonItem().title = "保存"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if tfPartnetMoney.text == "" {
            self.cmAlert("", msg: "请输入融资额(元)")
            return
        }
        
        if tfPartnetMoney.text?.integerValue == nil || tfPartnetMoney.text?.integerValue <= 0 {
            self.cmAlert("", msg: "您输入的融资额有误，必须是整数")
            return
        }
        
        if tfPartnetEquity.text == "" {
            self.cmAlert("", msg: "请输入股份(千分之)")
            return
        }
        
        if tfPartnetEquity.text?.integerValue == nil || tfPartnetEquity.text?.integerValue <= 0 {
            self.cmAlert("", msg: "您输入的股份有误，必须是整数")
            return
        }
        
        delegate?.onPartnerSet((tfPartnetMoney.text?.integerValue)!, partnerEquity: (tfPartnetEquity.text?.integerValue)!)
        self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
