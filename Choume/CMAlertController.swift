//
//  CMAlertController.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/6.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMAlertController: UIAlertController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.tintColor = theme.CMNavBGColor
    }
}
