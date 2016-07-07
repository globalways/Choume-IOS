import UIKit
import SVProgressHUD

class WalletVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var walletTableView: UITableView!
    @IBOutlet weak var labelPoint: UILabel!
    @IBOutlet weak var labelCB: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    
    let slidePanelStoryboard = UIStoryboard(name: "IBBSSlidePanel", bundle: NSBundle.mainBundle())
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
        loadDataToView()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureView()
        loadUserWallet()
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
    
    func loadDataToView(){
        labelPoint.text   = String(CMContext.currentUser!.point)
        labelCB.text      = String(CMContext.currentUser!.coin)
        labelBalance.text = Tool.fenToyuan((CMContext.currentUser?.user?.wallet?.amount)!)
    }
    
    func loadUserWallet() {
        APIClient.sharedInstance.getUserWallet(CMContext.sharedInstance.getToken()!, success: { (result) in
            if result.respStatus() == .OK {
                let wallet = result["wallet"].toUserWallet()
                CMContext.currentUser?.user?.wallet = wallet
                self.labelBalance.text = Tool.fenToyuan((CMContext.currentUser?.user?.wallet?.amount)!)
                self.labelPoint.text   = String(CMContext.currentUser!.point)
                self.labelCB.text      = String(CMContext.currentUser!.coin)
            }else {
                self.cmAlert("系统错误", msg: result.respMsg())
            }
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
        }
    }
    
    func rightBarItemClick(sender: UIBarButtonItem) {
        //帮助说明
        //let helpVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmHelpDetailVC) as! CMHelpDetailVC
        //self.navigationController?.pushViewController(helpVC, animated: true)
        loadUserWallet()
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
            let vc = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmWalletRechargeVC) as! CMWalletRechargeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmWalletExchangeVC) as! CMWalletExchangeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
