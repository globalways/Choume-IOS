//
//  IBBSCustomSelectedBackgroundView.swift
//  iBBS
//
//  Created by Augus on 10/6/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation



class IBBSCustomSelectedBackgroundView: UIView {

    var fillColor = CUSTOM_THEME_COLOR.lighterColor(0.8)

    override func drawRect(rect: CGRect) {
        let aRef = UIGraphicsGetCurrentContext()
        CGContextSaveGState(aRef)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 8.0)
        bezierPath.lineWidth = 8.0
        UIColor.whiteColor().setStroke()
        
        fillColor.setFill()
        
        bezierPath.stroke()
        bezierPath.fill()
        CGContextRestoreGState(aRef)
    }
}