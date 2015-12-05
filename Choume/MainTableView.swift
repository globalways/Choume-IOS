//
//  MainTableView.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/28.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class MainTableView: UITableView {
    
    init(frame: CGRect, style: UITableViewStyle, dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        super.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        separatorStyle = .None
        backgroundColor = theme.SDBackgroundColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
