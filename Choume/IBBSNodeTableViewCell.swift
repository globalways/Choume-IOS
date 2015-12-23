//
//  IBBSNodeTableViewCell.swift
//  iBBS
//
//  Created by Augus on 9/2/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit
import SwiftyJSON

class IBBSNodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfireImage: CMAvatarImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //        self.backgroundColor = UIColor.clearColor()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset                  = UIEdgeInsetsZero
        self.layoutMargins                   = UIEdgeInsetsZero
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadDataToCell(json: JSON){
        let avatarUrl                        = NSURL(string: json["avatar"].stringValue)
        print(avatarUrl)
        self.userProfireImage.kf_setImageWithURL(avatarUrl!, placeholderImage: AVATAR_PLACEHOLDER_IMAGE)
        self.topicLabel?.text                = json["title"].stringValue
        self.userName.text                   = json["username"].stringValue
        self.postTime.text                   = json["post_time"].stringValue
    }
    
}
