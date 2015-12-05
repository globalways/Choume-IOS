//
//  IBBSMessageTableViewCell.swift
//  iBBS
//
//  Created by Augus on 9/16/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit
import SwiftyJSON


class IBBSMessageTableViewCell: UITableViewCell {
    @IBOutlet var avatarImageView: IBBSAvatarImageView!
    @IBOutlet var isMessageRead: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    var isRead: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func loadDataToCell(json: JSON) {
        let imageUrl = NSURL(string: json["sender_avatar"].stringValue)
        avatarImageView.kf_setImageWithURL(imageUrl!, placeholderImage: AVATAR_PLACEHOLDER_IMAGE)
        timeLabel.text = json["send_time"].stringValue
        contentLabel.text = json["title"].stringValue
        
        isRead = json["is_read"].intValue
        if isRead == 0 {
            self.isMessageRead.image = UIImage(named: "message_is_read_marker")
            self.isMessageRead.changeColorForImageOfImageView(CUSTOM_THEME_COLOR.lighterColor(0.7))
        }else if isRead == 1{
            self.isMessageRead.image = UIImage(named: "message_is_read_marker")
        }
        
        let isAdministrator = json["type"].boolValue
        if !isAdministrator {
            self.avatarImageView.backgroundColor = UIColor.blackColor()
            self.avatarImageView.image = UIImage(named: "administrator")
            //                usernameLabel.text = json["username"].stringValue
            usernameLabel.text = "Admin"
        }else{
            usernameLabel.text = json["sender"].stringValue
            
        }
    }
    
    func changeColorForMessageMarker() {
        
    }
}
