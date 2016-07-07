//
//  Step2GoodsTC.swift
//  Choume
//
//  Created by wang on 16/4/28.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

protocol Step2GoodsTCDelegate {
    func onGoodsSet(goodsName:String, goodsAmount:Int)
}

class Step2GoodsTC: UITableViewController {
    @IBOutlet weak var tfGoodsName: UITextField!
    @IBOutlet weak var tfGoodsAmount: UITextField!
    
    var delegate: Step2GoodsTCDelegate?
    var defaultGoodsName: String = ""
    var defaultGoodsAmount: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if !defaultGoodsName.isEmpty {
            tfGoodsName.text = defaultGoodsName
        }
        if !defaultGoodsAmount.isEmpty {
            tfGoodsAmount.text = defaultGoodsAmount
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
        
        self.navigationItem.title = "筹集物品"
        self.editButtonItem().title = "保存"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if tfGoodsName.text == "" {
            self.cmAlert("", msg: "请输入物品名称")
            return
        }
        if tfGoodsAmount.text == "" {
            self.cmAlert("", msg: "请输入物品数量")
            return
        }
        
        if tfGoodsAmount.text?.integerValue == nil || tfGoodsAmount.text?.integerValue <= 0 {
            self.cmAlert("", msg: "您输入的物品数量有误，必须是大于0的整数")
            return
        }
        
        delegate?.onGoodsSet(tfGoodsName.text!, goodsAmount: (tfGoodsAmount.text?.integerValue)!)
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
