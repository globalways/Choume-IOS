//
//  JoinProjectCell.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/12/2.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

protocol ProjectToInvestDelegate {
    func onRewardClicked(reward: CfProjectReward)
}

class JoinProjectCell: UITableViewCell {

    var delegate: ProjectToInvestDelegate!
    var reward: CfProjectReward!
    @IBOutlet weak var labelRewardTitle: UILabel!
    
    @IBOutlet weak var labelRewardDesc: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var labelAlreadyCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        joinButton.addTarget(self, action: Selector("toNewInvest:"), forControlEvents: .TouchUpInside)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setReward(reward: CfProjectReward) {
        self.reward = reward
        labelRewardTitle.text = reward.supportType?.desc(reward.amount)
        labelRewardDesc.text = reward.desc
        labelAlreadyCount.text = "已支持数: " + String(reward.alreadyCount)
    }
    
    @IBAction private func toNewInvest(sender: UIButton){
        delegate!.onRewardClicked(reward)
    }

}
