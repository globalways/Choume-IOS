//
//  ProjectCommentInputView.swift
//  Choume
//
//  Created by wang on 16/5/31.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

protocol  CMCommentInputViewDelegate{
    func onOK(content: String)
}

class CMCommentInputView: UIToolbar {
    
    var textView: UITextView!
    var sendButton: UIButton!
    var inputDelegate: CMCommentInputViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
            textView = UITextView(frame: CGRectZero)
            textView.backgroundColor = UIColor(white: 250/255, alpha: 1)
//            textView.delegate = self
            textView.font = UIFont.systemFontOfSize(17)
            textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor
            textView.layer.borderWidth = 0.5
            textView.layer.cornerRadius = 5
            textView.scrollsToTop = false
            textView.textContainerInset = UIEdgeInsetsMake(4, 3, 3, 3)
            self.addSubview(textView)
            
            sendButton = UIButton(type: .System)
            sendButton.enabled = true
            sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
            sendButton.setTitle("发送", forState: .Normal)
            sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: .Disabled)
            sendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: .Normal)
            sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            sendButton.addTarget(self, action: #selector(CMCommentInputView.tapToNewComment), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(sendButton)
            
            // 对组件进行Autolayout设置
            textView.translatesAutoresizingMaskIntoConstraints = false
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 8))
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 7.5))
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Right, relatedBy: .Equal, toItem: sendButton, attribute: .Left, multiplier: 1, constant: -2))
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -8))
            self.addConstraint(NSLayoutConstraint(item: sendButton, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: sendButton, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -4.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func tapToNewComment(sender:UIButton) {
        print(textView.text)
        //inputDelegate.onOK("xx")
    }
}
