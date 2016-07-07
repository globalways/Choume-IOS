//
//  CMProjectRewardCell.swift
//  Choume
//
//  Created by wang on 16/5/16.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectRewardCell: UITableViewCell {
    @IBOutlet weak var labelRewardTitle: UILabel!
    @IBOutlet weak var labelRewardAbbr: UILabel!
    @IBOutlet weak var labelRewards: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setReward(reward: CfProjectReward) {
        labelRewardTitle.text = reward.desc
        labelRewardAbbr.text = reward.supportType?.desc(reward.amount)
        labelRewards.text = "支持数: " + String(reward.alreadyCount)
    }
    
}
