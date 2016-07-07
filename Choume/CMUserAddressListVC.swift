//
//  CMUserAddressTVC.swift
//

import UIKit

class CMUserAddressTVC: UITableViewController {

    var addressList: [UserAddressModel] = []
    
    // action 代表启动本vc的目的
    // 100 = 个人中心-地址管理, 101 = 参与项目-选择地址
    var action = 100
    
    override func viewWillAppear(animated: Bool) {
        addressList.removeAll()
        if let addrs = CMContext.currentUser?.user!.addrs {
            for i in 0 ... addrs.count - 1{
                let addr: UserAddress = addrs[i]
                let uam = UserAddressModel(name: addr.name!, phone: addr.contact!, address: addr.area! + " " + addr.detail!)
                addressList.append(uam)
            }
            self.tableView.reloadData()
        }
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = #selector(CMUserAddressTVC.finish)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.userAddressCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.userAddressCell)
        if action == 101 {
            self.navigationItem.title = "选择地址"
        }
    }
    
    func finish(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func cancelAddressDetail(segue: UIStoryboardSegue){}

}

extension CMUserAddressTVC {
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressList.count != 0 && section == 0{
            return addressList.count
        }else if section == 1{
            return 1
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.userAddressCell, forIndexPath: indexPath) as? UserAddressCell {
                cell.loadDataToCell(addressList[indexPath.row])
                return cell
            }
        }else if indexPath.section == 1{
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            //cell.imageView?.image = UIImage(named: "gallery3")
            //cell.detailTextLabel?.text = "detail wang"
            cell.textLabel?.text = "新增收获地址"
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 参与项目选择了地址
        if action == 101 {
            let dict = ["addr": CMContext.currentUser!.user!.addrs![indexPath.row]]
            NSNotificationCenter.defaultCenter().postNotificationName(kNewInvestDidSelectedAddr, object: nil, userInfo: dict)
            self.navigationController?.popViewControllerAnimated(true)
        }else {
            
        }
    }
}
