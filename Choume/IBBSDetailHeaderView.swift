//
//  IBBSDetailHeaderView.swift
//  iBBS
//
//  Created by Augus on 9/4/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit
import SwiftyJSON

class IBBSDetailHeaderView: UIView {
    @IBOutlet weak var headerTitleLabel: UILabel!{
        didSet{
            headerTitleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var avatarImageView: CMAvatarImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var content: UITextView!

    var nodeName: String?
    
    func loadData(json: JSON){
        
        let avatarUrl = NSURL(string: json["avatar"].stringValue)
        avatarImageView.kf_setImageWithURL(avatarUrl!, placeholderImage: AVATAR_PLACEHOLDER_IMAGE)
        usernameLabel?.text = json["username"].stringValue
        headerTitleLabel?.text = json["title"].stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        timeLabel?.text = json["post_time"].stringValue
        let data = json["post_content"].stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.content.ausAttributedText(data)
//        self.content.ausAutomanticResizeTextViewFrameSize()
        print(json["post_content"].stringValue)

        nodeName = json["board"].stringValue
    }
    
}
