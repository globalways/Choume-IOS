//
//  CMSlidePanelNoLogin.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/16.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMSlidePanelNoLogin: UIView {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var signupLabel: UILabel!
    let LOGINTAP = 1001
    let HELPTAP = 1002
    let REGISTERTAP = 1003
    var loginBtnGR: UITapGestureRecognizer!
    var helpLabelGR: UITapGestureRecognizer!
    var signupLabelGR: UITapGestureRecognizer!
    weak var delegate: CMSlidePanelNoLoginDelegate?

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SlidePanelNoLogin", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CMSlidePanelNoLogin
    }
    
    override func drawRect(rect: CGRect) {
        loginBtn.tag = LOGINTAP
        helpLabel.tag = HELPTAP
        signupLabel.tag = REGISTERTAP
        
        loginBtn.layer.cornerRadius = 15
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = theme.CMWhite.CGColor
        //重新计算y值
        helpLabel.frame.origin.y = (height - 260)/3 + 210
        
        loginBtnGR = UITapGestureRecognizer(target: self, action: "labelPressed:")
        loginBtn.addGestureRecognizer(loginBtnGR)
        helpLabelGR = UITapGestureRecognizer(target: self, action: "labelPressed:")
        helpLabel.userInteractionEnabled = true
        helpLabel.addGestureRecognizer(helpLabelGR)
        signupLabelGR = UITapGestureRecognizer(target: self, action: "labelPressed:")
        signupLabel.userInteractionEnabled = true
        signupLabel.addGestureRecognizer(signupLabelGR)
    }
    
    func labelPressed(sender: UITapGestureRecognizer){
        delegate?.nologinView(self, didTapView: sender)
    }

}

protocol CMSlidePanelNoLoginDelegate: NSObjectProtocol{
    func nologinView(noLoginView: CMSlidePanelNoLogin, didTapView sender: UITapGestureRecognizer)
}
