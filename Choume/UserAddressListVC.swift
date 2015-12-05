//
//  UserAddressTableViewController.swift
//
//  Created by 汪阳坪 on 15/11/19.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class UserAddressTableViewController: UITableViewController {

    var addressList: [UserAddressModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        let address1 = UserAddressModel(name: "我是王八蛋",phone: "135213462234",address: "xxxxxxx")
        let address2 = UserAddressModel(name: "lisi", phone: "13275847509", address: "addresslisi")
        let address3 = UserAddressModel(name: "wanger", phone: "15828525253", address: "address_wanger")
        
        addressList.append(address1)
        addressList.append(address2)
        addressList.append(address3)
        
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.userAddressCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.userAddressCell)
        
        //测试custom cell
        //tableView.registerClass(vDataEntryCell.classForCoder(), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
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
        

        // Configure the cell...

        return UITableViewCell()
    }
    // hide table view section header - by wyp
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    @IBAction func cancelAddressDetail(segue: UIStoryboardSegue){
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    class vDataEntryCell: UITableViewCell
    {
        
        //-----------------
        // MARK: PROPERTIES
        //-----------------
        
        //Locals
        var textField : UITextField = UITextField()
        
        //-----------------
        // MARK: VIEW FUNCTIONS
        //-----------------
        
        ///------------
        //Method: Init with Style
        //Purpose:
        //Notes: This will NOT get called unless you call "registerClass, forCellReuseIdentifier" on your tableview
        ///------------
        override init(style: UITableViewCellStyle, reuseIdentifier: String!)
        {
            //First Call Super
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            //Initialize Text Field
            self.textField = UITextField(frame: CGRect(x: 119.00, y: 9, width: 216.00, height: 31.00));
            
            //Add TextField to SubView
            self.addSubview(self.textField)
        }
        
        
        ///------------
        //Method: Init with Coder
        //Purpose:
        //Notes: This function is apparently required; gets called by default if you don't call "registerClass, forCellReuseIdentifier" on your tableview
        ///------------
        required init(coder aDecoder: NSCoder)
        {
            //Just Call Super
            super.init(coder: aDecoder)!
        }
    }

}
