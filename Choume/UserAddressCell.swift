//
//  UserAddressCell.swift
//
//  Created by 汪阳坪 on 15/11/18.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class UserAddressCell: UITableViewCell {

    @IBOutlet weak var contactsNameLabel: UILabel!
    @IBOutlet weak var contactsPhoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins  = UIEdgeInsetsZero
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadDataToCell(model: UserAddressModel){
        contactsNameLabel.text = model.contactsName
        contactsPhoneLabel.text = model.contactsPhone
        addressLabel.text = model.address
    }
    
    func setAddr(addr: UserAddress) {
        contactsNameLabel.text = addr.name
        contactsPhoneLabel.text = addr.contact
        addressLabel.text = String(stringInterpolation: addr.area!, " ", addr.detail!)
    }
}
