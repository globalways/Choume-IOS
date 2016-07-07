//
//  CMTableViewFourRadioBtnCell.swift
//  Choume
//
//  Created by wang on 16/4/20.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import DLRadioButton

class CMFourRadioBtnCell: UITableViewCell {

    @IBOutlet weak var btnMoney: DLRadioButton!
    @IBOutlet weak var btnPeople: DLRadioButton!
    @IBOutlet weak var btnGoods: DLRadioButton!
    @IBOutlet weak var btnEquity: DLRadioButton!
    
    var delegate: FourRadioBtnCellDelegate?
    var btns:[DLRadioButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // first button not in the array -> ex:https://github.com/DavydLiu/DLRadioButton/blob/master/Example/DLRadioButtonExample/DemoViewController.swift
        //btns.append(btnMoney)
        btns.append(btnPeople)
        btns.append(btnGoods)
        btns.append(btnEquity)
        
        btnMoney.setTitle("钱", forState: .Normal)
        btnMoney.tag = 1001
        btnPeople.setTitle("人", forState: .Normal)
        btnPeople.tag = 1002
        btnGoods.setTitle("物", forState: .Normal)
        btnGoods.tag = 1003
        btnEquity.setTitle("股权", forState: .Normal)
        btnEquity.tag = 1004
        
        //btnMoney.titleLabel?.text = "xxbb"
        //btnMoney.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //btnMoney.indicatorSize = 10
        //btnMoney.indicatorColor = UIColor.blueColor()
        //btnMoney.iconSize = 20
        //btnMoney.iconColor = UIColor.redColor()
        
        initBtnStyle(btnMoney)
        for index in 0...btns.count-1 {
            initBtnStyle(btns[index])
        }
        
        btnMoney.otherButtons = btns
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initBtnStyle(btn: DLRadioButton){
        btn.setTitleColor(theme.CMGray333333 , forState: .Normal)
        btn.indicatorSize = 10
        btn.indicatorColor = theme.CMNavBGColor
        btn.iconSize = 20
        btn.iconColor = theme.CMNavBGColor
        
        btn.contentHorizontalAlignment = .Left
        btn.addTarget(self, action: "radioSelect:", forControlEvents: .TouchUpInside)
    }
    
    @IBAction private func radioSelect(radioBtn: DLRadioButton){
        delegate?.onRadioSelected(radioBtn)
        //print(String(format: "%@ is selected.\n", radioBtn.selectedButton()!.titleLabel!.text!));
    }
    
}

protocol FourRadioBtnCellDelegate {
    func onRadioSelected(btn: DLRadioButton)
}
