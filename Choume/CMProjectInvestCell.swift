//
//  CMProjectInvestCell.swift
//  Choume
//
//  Created by wang on 16/5/16.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectInvestCell: UITableViewCell {
    @IBOutlet weak var ivInvesterAvatar: CMAvatarImageView! {
        didSet{
            ivInvesterAvatar.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            ivInvesterAvatar.image = AVATAR_PLACEHOLDER_IMAGE
        }
    }
    @IBOutlet weak var labelInvesterName: UILabel!
    @IBOutlet weak var labelInvesterAbbr: UILabel!
    @IBOutlet weak var labelInvestTime: UILabel!
    @IBOutlet weak var labelStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInvest(i:CfProjectInvest) {
        labelInvesterName.text = i.investorNick == nil ? "用户名错误": i.investorNick
        labelInvesterAbbr.text = Tool.generateAbbr(i)
        labelInvestTime.text = Tool.formatTime(i.investTime)
        labelStatus.text = i.status?.desc()
        ivInvesterAvatar.sd_setImageWithURL(NSURL(string: i.investorAvatar), placeholderImage: UIImage(named: "Administrator"))
    }
    
}
