import UIKit

class WalletVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var walletTableView: UITableView!
    
    let slidePanelStoryboard = UIStoryboard(name: "IBBSSlidePanel", bundle: NSBundle.mainBundle())
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        configureView()
    }
    
    func configureView(){
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "rightBarItemClick:"
        //透明状态栏和导航栏
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
    }
    
    func rightBarItemClick(sender: UIBarButtonItem) {
        let helpVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmHelpDetailVC) as! CMHelpDetailVC
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.whiteColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row == 0 {
            cell.textLabel?.text = "充值"
            cell.imageView?.image = UIImage(named: "Icon-Up")
        }else {
            cell.textLabel?.text = "兑换"
            cell.imageView?.image = UIImage(named: "Icon-Down")
        }
        cell.textLabel?.font = UIFont(name: "", size: 12)
        cell.textLabel?.textColor = UIColor(hex: "#333333")
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
//            let canNotUseAlert = CMAlertController(title: "", message: "测试账户不支持充值！", preferredStyle:.Alert)
//            canNotUseAlert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: nil))
//            self.presentViewController(canNotUseAlert, animated: true, completion: nil)
            let vc = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmWalletRechargeVC) as! CMWalletRechargeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let canNotUseAlert = CMAlertController(title: "", message: "测试账户不支持兑换！", preferredStyle:.Alert)
            canNotUseAlert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: nil))
            self.presentViewController(canNotUseAlert, animated: true, completion: nil)
        }
    }
}
