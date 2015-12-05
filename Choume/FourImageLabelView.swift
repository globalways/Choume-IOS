//
//  FourImageLabelView.swift
//
//  Created by 汪阳坪 on 15/12/2.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class FourImageLabelView: UIView {
    private let firstBtn: NoHighlightButton = NoHighlightButton()
    private let secondBtn: NoHighlightButton = NoHighlightButton()
    private let thirdBtn: NoHighlightButton = NoHighlightButton()
    private let fourthBtn: NoHighlightButton = NoHighlightButton()
    var buttons: [NoHighlightButton]!
    private let textColor: UIColor = theme.CMGray333333
    private let textFont: UIFont = UIFont.systemFontOfSize(8)
    
    convenience init(texts: [String], images: [String]){
        self.init()
        buttons = [firstBtn, secondBtn, thirdBtn, fourthBtn]
        setButtons(texts, images: images)
    }
    
    func setButtons(texts: [String], images: [String]){
        let btnWidth = width/4.0 - 30
        for var i=0;i<texts.count;i++ {
            
            buttons[i].frame = CGRectMake(15+CGFloat(30*i)+btnWidth*CGFloat(i), 0, btnWidth, height)
            buttons[i].setTitle(texts[i], forState: .Normal)
            buttons[i].setTitleColor(textColor, forState: .Normal)
            buttons[i].titleLabel?.font = textFont
            buttons[i].setImage(UIImage(named: images[i]), forState: .Normal)
            buttons[i].contentHorizontalAlignment = .Center
            buttons[i].contentVerticalAlignment = .Top
            let totalH = (buttons[i].imageView?.height)! + (buttons[i].titleLabel?.height)!
            //print((buttons[i].width - (buttons[i].imageView?.width)!))
            buttons[i].imageEdgeInsets = UIEdgeInsetsMake(10, (buttons[i].width - (buttons[i].imageView?.width)!) , 0.0, 0.0)
            var x =  (buttons[i].imageView?.width)! - buttons[i].width/2 + (buttons[i].titleLabel?.width)!/2
            buttons[i].titleEdgeInsets = UIEdgeInsetsMake((buttons[i].imageView?.height)! + 25.0, -(buttons[i].imageView?.x)! - x, 0.0 , 0.0)
            
            addSubview(buttons[i])
        }
    }
    
    override func layoutSubviews() {
        let btnWidth = width/4.0 - 30
        for index in 0...3{
            buttons[index].frame = CGRectMake(15+CGFloat(30*index)+btnWidth*CGFloat(index), 0, btnWidth, height)
        }
    }
}
