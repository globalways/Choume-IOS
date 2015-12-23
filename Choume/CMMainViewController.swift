import UIKit

class CMMainViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet weak var toLeftPanel: UIBarButtonItem!
    @IBOutlet weak var galleryScrollView: UIScrollView!
    @IBOutlet weak var galleryPageControl: UIPageControl!
    
    @IBOutlet weak var contentContainerScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    var timer: NSTimer!
    var containerVC: ContainerViewController!
    
    let slidePanelStoryboard = UIStoryboard(name: "IBBSSlidePanel", bundle: NSBundle.mainBundle())
    let firstScrollViewCellNames: [String] = ["筹乐子","筹票子","筹爱心"]
    let firstScrollViewCellImage:[String] = ["Icon-lezi","Icon-piaozi","Icon-aixin"]
    let secondScrollViewCellNames: [String] = ["一元秒筹","限时特筹","世纪难题","周末去哪","热门众筹","非筹不可"]
    let secondScrollViewCellImage: [String] = ["Icon-main-s2-0","Icon-main-s2-1","Icon-main-s2-2","Icon-main-s2-3","Icon-main-s2-4","Icon-main-s2-5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureGallery()
        toLeftPanel.target = self
        toLeftPanel.action = Selector("toLeftPanelItemSelected")
        if self.parentViewController != nil {
          containerVC = self.parentViewController?.parentViewController as! ContainerViewController
        }
        contentContainerScrollView.contentSize = scrollContentView.frame.size
        setCollectionViews()
        
        let newWidth = (AppWidth - 50)/2
        let newHeight = CGFloat(66.0/154.0) * newWidth
        
        image1.addConstraint(NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: newHeight))
        
        image1.addConstraint(NSLayoutConstraint(item: image1, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: newWidth))
        
        image2.addConstraint(NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: newHeight))
        
        image2.addConstraint(NSLayoutConstraint(item: image2, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: newWidth))
        
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
        let imageW: CGFloat = AppWidth
        let imageH: CGFloat = self.galleryScrollView.frame.size.height
        var imageY: CGFloat = 0
        var totalCount: NSInteger = 3
        for index in 0..<totalCount {
            var imageView: UIImageView  = UIImageView()
            let imageX: CGFloat = CGFloat(index) * imageW
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            let name: String = String(format: "gallery%d", index+1)
            imageView.image = UIImage(named: name)
//            imageView.contentMode = .ScaleAspectFill
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
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
        resetTimer()
    }
    func resetTimer() {
        self.timer.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "nextImage:", userInfo: nil, repeats: true)
    }
    func addTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "nextImage:", userInfo: nil, repeats: true)
    }
}

extension CMMainViewController {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CellIdentifiers.imageLabelViewCell, forIndexPath: indexPath) as! ImageLabelViewCell
        if collectionView == firstCollectionView {
            cell.image.image = UIImage(named: firstScrollViewCellImage[indexPath.row])
            cell.label.text = firstScrollViewCellNames[indexPath.row]
        }else {
            cell.image.image = UIImage(named: secondScrollViewCellImage[indexPath.item + indexPath.section*3])
            cell.label.text = secondScrollViewCellNames[indexPath.item + indexPath.section*3]
        }
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.startedNav) as! ProjectListNavViewController
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageLabelViewCell
        destinationVC.setType(.Default,title: cell.label.text!)
        self.navigationController?.showViewController(destinationVC, sender: nil)

    }
    
    @IBAction func cancelToSlidePanel(segue: UIStoryboardSegue){}
}
