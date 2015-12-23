//
//  CMWalletRecharge.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/15.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMWalletRechargeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var toPayBtn: UIButton!
    @IBOutlet weak var rechargerTableVIew: UITableView!
    private var moneyCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        toPayBtn.layer.cornerRadius = 5.0
        rechargerTableVIew.dataSource = self
        rechargerTableVIew.delegate = self
        rechargerTableVIew.registerNib(UINib(nibName: "CMWalletRechargeMoneyCell", bundle: nil), forCellReuseIdentifier: "cmWalletRechargeMoneyCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.whiteColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("cmWalletRechargeMoneyCell") as! CMWalletRechargeMoneyCell
            
        }else {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            cell.textLabel?.text = "付款方式"
            cell.detailTextLabel?.text = "支付宝"
            cell.accessoryType = .DisclosureIndicator
        }
        cell.textLabel?.font = UIFont(name: "", size: 12)
        cell.textLabel?.textColor = UIColor(hex: "#333333")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

}
