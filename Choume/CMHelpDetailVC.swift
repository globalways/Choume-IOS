//
//  CMHelpDetailVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/7.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMHelpDetailVC: UIViewController {
    @IBOutlet weak var helpContentTextView: UITextView!
    override func viewDidLoad() {
        navigationItem.title = "换算说明"
        helpContentTextView.text = "1、什么是筹币？\n 筹币是能够在筹么平台流通交换的价值体系。\n\n 2、如何换算？\n 1人民币 ＝ 100筹币，充值人民币转换为筹币，但是筹币不能转换为人民币。\n\n3、什么是积分？\n 积分是用于用户价值评价体系的量化标准。\n\n4、如何获取和消费积分？\n  获取积分：a.系统赠送 b.筹币兑换积分(1筹币＝100积分) \n  消费积分：积分可用于用户抽奖等。 "
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
    }
}
