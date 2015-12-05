import UIKit

class UserAddressModel: NSObject {
    var contactsName: String?
    var contactsPhone: String?
    var address: String?
    
    init(name: String, phone: String, address: String) {
        self.contactsName = name
        self.contactsPhone = phone
        self.address = address
    }
}
