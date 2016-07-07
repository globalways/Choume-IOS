//
//  Step2MoneyTC.swift
//  Choume
//
//  Created by wang on 16/4/24.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

protocol Step2MoneyTCDelegate {
    func onMoneySet(money:Int)
}

class Step2MoneyTC: UITableViewController {
    
    @IBOutlet weak var tfMoney: UITextField!
    
    var delegate: Step2MoneyTCDelegate?
    var defaultMoney: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let tmpMoney = defaultMoney {
           tfMoney.text = tmpMoney
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
        
        self.navigationItem.title = "筹资金额"
        self.editButtonItem().title = "保存"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if tfMoney.text == "" {
            self.cmAlert("", msg: "请输入金额")
            return
        }
        
        if tfMoney.text?.integerValue == nil || tfMoney.text?.integerValue <= 0{
            self.cmAlert("", msg: "您输入的金额有误，必须是大于0的整数")
            return
        }
        
        delegate?.onMoneySet((tfMoney.text?.integerValue)!)
        self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
