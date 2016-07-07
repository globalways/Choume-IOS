//
//  CMProjectCommentCell.swift
//  Choume
//
//  Created by wang on 16/5/24.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectCommentCell: UITableViewCell {
    
    private var comment: CfProjectComment?
    
    @IBOutlet weak var ivUserAvatar: UIImageView!
    @IBOutlet weak var labelUserNick: UILabel!
    @IBOutlet weak var labelReply: UILabel!
    @IBOutlet weak var labelReplyTo: UILabel!
    @IBOutlet weak var labelReplyContent: ActiveLabel!
    @IBOutlet weak var labelReplyTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setComment(c: CfProjectComment) {
        self.comment = c
        ivUserAvatar.sd_setImageWithURL(NSURL(string: c.avatar), placeholderImage: UIImage(named: "Administrator"))
        labelUserNick.text = c.userNick
        var contentFullStr = ""
        labelReplyTime.text = Tool.formatTime(c.time)
        if c.repliedUserNick != nil {
            contentFullStr += "回复 @"
            contentFullStr += c.repliedUserNick! + ": "
        }
        contentFullStr += c.content!
        labelReplyContent.text = contentFullStr
    }
    
}
