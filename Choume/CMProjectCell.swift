//
//  CMProjectCell.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/24.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class CMProjectCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectSubNameLabel: UILabel!
    @IBOutlet weak var projectProgress: UIProgressView!
    @IBOutlet weak var projectUserAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        projectProgress.progressTintColor = theme.CMNavBGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
