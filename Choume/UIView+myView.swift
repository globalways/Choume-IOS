//
//  UIView+myView.swift
//
//  Created by 汪阳坪 on 15/11/28.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import Foundation

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
}
