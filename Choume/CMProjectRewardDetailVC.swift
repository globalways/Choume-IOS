//
//  CMProjectRewardDetailVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/16.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

protocol CMProjectRewardDetailVCDelegate{
    func onSetProjectReward(reward: CfProjectReward, forIndex: Int)
}

class CMProjectRewardDetailVC: UITableViewController {


    @IBOutlet weak var needSupportDetailLabel: UILabel!
    
    @IBOutlet weak var rewardTitle: UITextField!
    @IBOutlet weak var rewardDesc: UITextField!
    @IBOutlet weak var rewardContact: UITextField!
    @IBOutlet weak var rewardTel: UITextField!
    @IBOutlet weak var rewardLimit: UITextField!
    //回报方式的索引
    var rewardIndex: Int?
    var delegate: CMProjectRewardDetailVCDelegate?
    var customTitle: String = "回报方式"
    var currentReward: CfProjectReward?
    //需要支持detail描述
    private var needSupportText: String = "" {
        didSet {
            needSupportDetailLabel.text = needSupportText
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if rewardIndex != -1 {
            rewardDesc.text = currentReward?.desc
            rewardLimit.text = currentReward?.limitedCount?.stringValue
            needSupportText = (currentReward?.supportType?.desc((currentReward?.amount)!))!
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        
        self.navigationItem.title = customTitle
        self.editButtonItem().title = "保存"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if currentReward == nil {
            currentReward = CfProjectReward()
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        // save data here
//        if rewardTitle.text == "" {
//            self.cmAlert("", msg: REWARD_HAS_NO_TITLE)
//            return
//        }
        
        if rewardDesc.text == "" {
            self.cmAlert("", msg: REWARD_HAS_NO_DESC)
            return
        }
        
        if needSupportText == "" {
            self.cmAlert("", msg: REWARD_HAS_NO_SUPPORT_TYPE)
            return
        }
        
        if let limit = rewardLimit.text?.uint64Value {
            currentReward?.limitedCount = limit
        }else{
            self.cmAlert("", msg: REWARD_NEED_LIMIT)
            return
        }
        currentReward?.desc = rewardDesc.text!
        delegate?.onSetProjectReward(currentReward!, forIndex: rewardIndex!)
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier ==  "toSelectSupportType" {
            let vc = segue.destinationViewController as! CMProjectRewardSupportTypeVC
            vc.delegate = self
        }
    }


}

extension CMProjectRewardDetailVC: CMProjectRewardSupportTypeVCDelegate {
    func supportTypeAndCount(type: CfProjectSupportType, count: UInt64){
        currentReward?.supportType = type
        currentReward?.amount = count
        needSupportText = type.desc(count)
    }
}
