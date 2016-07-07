//
//  DoubleTextView.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/28.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

import UIKit

class DoubleTextView: UIView {
    
    private let leftTextButton: NoHighlightButton =  NoHighlightButton()
    private let rightTextButton: NoHighlightButton = NoHighlightButton()
    private let centerTextButton: NoHighlightButton = NoHighlightButton()
    
    
    private let textColorFroNormal: UIColor = theme.CMGray333333
    private let textFont: UIFont = UIFont.systemFontOfSize(15)
    private let bottomHighlightLineView: UIView = UIView()
    private let bottomLineView:UIView = UIView()
    private var selectedBtn: UIButton?
    weak var delegate: DoubleTextViewDelegate?
    
    /// 便利构造方法
    convenience init(leftText: String, rigthText: String, centerText: String) {
        self.init()
        // 设置左边文字
        setButton(leftTextButton, title: leftText, tag: 100)
        // 设置右边文字
        setButton(rightTextButton, title: rigthText, tag: 102)
        setButton(centerTextButton, title: centerText, tag: 101)
        // 设置底部线条View
        setBottomLineView()
        
        titleButtonClick(leftTextButton)
    }
    
    private func setBottomLineView() {
        bottomHighlightLineView.backgroundColor = theme.CMNavBGColor
        bottomLineView.backgroundColor = theme.CMGrayLight
        addSubview(bottomLineView)
        addSubview(bottomHighlightLineView)
    }
    
    private func setButton(button: UIButton, title: String, tag: Int) {
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitleColor(textColorFroNormal, forState: .Normal)
        button.titleLabel?.font = textFont
        button.tag = tag
        button.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = CGFloat( (width-30) / 3 )
        leftTextButton.frame = CGRectMake(15, 0, btnW, height)
        leftTextButton.contentHorizontalAlignment = .Center
        centerTextButton.frame = CGRectMake(btnW+15, 0, btnW, height)
        centerTextButton.contentHorizontalAlignment = .Center
        rightTextButton.frame = CGRectMake(btnW*2+15, 0, btnW, height)
        rightTextButton.contentHorizontalAlignment = .Center
        //初始选择第一个按钮
        bottomHighlightLineView.frame = CGRectMake(15+4, height - 2, btnW-8, 1)
        bottomLineView.frame = CGRectMake(self.x, height - 2, self.width, 1)
        
    }
    
    func titleButtonClick(sender: UIButton) {
        selectedBtn?.selected = false
        sender.selected = true
        selectedBtn = sender
        bottomViewScrollTo(sender.tag - 100)
        delegate?.doubleTextView(self, didClickBtn: sender, forIndex: sender.tag - 100)
    }
    
    func bottomViewScrollTo(index: Int) {
        var offset: CGFloat!
        if index == 0 {
            offset = 15 + 4
            //offset = leftTextButton.titleLabel?.frame.origin.x
        }else if index == 1 {
            offset = 15 + leftTextButton.width + 4
        }else if index == 2 {
            offset = 15+4 + 2*leftTextButton.width
        }
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bottomHighlightLineView.frame.origin.x = offset
        })
    }
    
    func clickBtnToIndex(index: Int) {
        let btn: NoHighlightButton = self.viewWithTag(index + 100) as! NoHighlightButton
        self.titleButtonClick(btn)
    }
}

/// DoubleTextViewDelegate协议
protocol DoubleTextViewDelegate: NSObjectProtocol{
    
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int)
    
}

/// 没有高亮状态的按钮
class NoHighlightButton: UIButton {
    /// 重写setFrame方法
    override var highlighted: Bool {
        didSet{
            super.highlighted = false
        }
    }
}
