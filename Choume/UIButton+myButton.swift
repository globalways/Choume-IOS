//
//  UIButton+myButton.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/16.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import Foundation
extension UIButton {
    func centerLabelVerticallyWithPadding(spacing:CGFloat) {
        // update positioning of image and title
        
        let imageSize = self.imageView!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top:0,
            left:-imageSize.width,
            bottom:-(imageSize.height + spacing),
            right:0)
        let titleSize = self.titleLabel!.frame.size
        self.imageEdgeInsets = UIEdgeInsets(top:-(titleSize.height + spacing),
            left:0,
            bottom: 0,
            //original right -titleSize.width http://stackoverflow.com/questions/12770751/uibutton-with-title-under-the-imageview
            //by wyp
            right:-2*titleSize.width-width/2)
        
        // reset contentInset, so intrinsicContentSize() is still accurate
        let trueContentSize = CGRectUnion(self.titleLabel!.frame, self.imageView!.frame).size
        let oldContentSize = self.intrinsicContentSize()
        let heightDelta = trueContentSize.height - oldContentSize.height
        let widthDelta = trueContentSize.width - oldContentSize.width
        self.contentEdgeInsets = UIEdgeInsets(top:heightDelta/2.0,
            left:widthDelta/2.0,
            bottom:heightDelta/2.0,
            right:widthDelta/2.0)
    }
}