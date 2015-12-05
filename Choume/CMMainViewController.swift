import UIKit

class CMMainViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var toLeftPanel: UIBarButtonItem!
    @IBOutlet weak var galleryScrollView: UIScrollView!
    @IBOutlet weak var galleryPageControl: UIPageControl!
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    var timer: NSTimer!
    var containerVC: ContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureGallery()
        toLeftPanel.target = self
        toLeftPanel.action = Selector("toLeftPanelItemSelected")
        if self.parentViewController != nil {
          containerVC = self.parentViewController?.parentViewController as! ContainerViewController
        }
        setCollectionViews()
    }
    func toLeftPanelItemSelected(){
        containerVC.toggleLeftPanel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMGray333333]
        self.navigationItem.leftBarButtonItem?.tintColor = theme.CMGray333333
    }
    
    func setCollectionViews(){
        firstCollectionView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.imageLabelViewCell, bundle: nil), forCellWithReuseIdentifier: MainStoryboard.CellIdentifiers.imageLabelViewCell)
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.imageLabelViewCell, bundle: nil), forCellWithReuseIdentifier: MainStoryboard.CellIdentifiers.imageLabelViewCell)
    }
    
    func pictureGallery() {
        let imageW: CGFloat = self.galleryScrollView.frame.size.width
        let imageH: CGFloat = self.galleryScrollView.frame.size.height
        var imageY: CGFloat = 0
        var totalCount: NSInteger = 3
        for index in 0..<totalCount {
            var imageView: UIImageView  = UIImageView()
            let imageX: CGFloat = CGFloat(index) * imageW
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            let name: String = String(format: "gallery%d", index+1)
            imageView.image = UIImage(named: name)
            self.galleryScrollView.showsHorizontalScrollIndicator = false
            self.galleryScrollView.addSubview(imageView)
        }
        
        let contentW: CGFloat = imageW * CGFloat(totalCount)
        self.galleryScrollView.contentSize = CGSizeMake(contentW, 0)
        self.galleryScrollView.pagingEnabled = true
        self.galleryScrollView.delegate = self
        self.galleryPageControl.numberOfPages = totalCount
        self.addTimer()
    }
    
    func nextImage(sender:AnyObject!) {
        var page: Int = self.galleryPageControl.currentPage
        if(page == 2){
            page = 0
        }else{
            page++
        }
        
        let x: CGFloat = CGFloat(page) * self.galleryScrollView.frame.size.width
        self.galleryScrollView.contentOffset = CGPointMake(x, 0)
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollViewW: CGFloat = galleryScrollView.frame.size.width
        let x: CGFloat = galleryScrollView.contentOffset.x
        let page:Int = (Int)((x + scrollViewW / 2) / scrollViewW);
        self.galleryPageControl.currentPage = page;
    }
    func addTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "nextImage:", userInfo: nil, repeats: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CMMainViewController {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CellIdentifiers.imageLabelViewCell, forIndexPath: indexPath) as! ImageLabelViewCell
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == secondCollectionView {
            return 2
        }
        return 1
    }
}
