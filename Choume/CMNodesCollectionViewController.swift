//
//  CMNodesCollectionViewController.swift
//  iBBS
//
//  Created by Augus on 9/2/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//


import UIKit
import SwiftyJSON
import GearRefreshControl

class CMNodesCollectionViewController: UICollectionViewController {
    
    var gearRefreshControl: GearRefreshControl!
    
    var nodesArray: [JSON]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IBBSConfigureNodesInfo.sharedInstance.configureNodesInfo()
        self.nodesArray = IBBSConfigureNodesInfo.sharedInstance.nodesArray
        self.gearRefreshManager()

        self.collectionView?.addSubview(gearRefreshControl)
        self.collectionView?.alwaysBounceVertical = true
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = TITLE_ALL_NODES
    
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: CUSTOM_THEME_COLOR]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTheme", name: kThemeDidChangeNotification, object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false

    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - update theme
    func updateTheme() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : CUSTOM_THEME_COLOR]
        if let cells = self.collectionView?.visibleCells() as? [IBBSNodesCollectionViewCell] {
            for index in 0 ..< cells.count {
                let cell = cells[index]
                cell.imageView.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.75)
                cell.imageView.layer.shadowColor = CUSTOM_THEME_COLOR.darkerColor(0.9).CGColor
                cell.customBackgroundView?.fillColor = CUSTOM_THEME_COLOR.lighterColor(0.8)
                cell.customBackgroundView?.setNeedsDisplay()
            }
        }
        
        gearRefreshControl?.removeFromSuperview()
        gearRefreshManager()
        self.collectionView?.addSubview(gearRefreshControl)
    }
    
    // MARK: - Collection view data source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.nodesArray?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CollectionCellIdentifiers.nodeCollectionCell, forIndexPath: indexPath) as? IBBSNodesCollectionViewCell {
//            self.nodesArray = IBBSConfigureNodesInfo.sharedInstance.nodesArray
            if let array = self.nodesArray {
                
                let json = array[indexPath.row]
                print(json)
                cell.infoLabel?.text = json["name"].stringValue
                
            }
            return cell

        }
        return UICollectionViewCell()
    }
  
    // MARK: - Collection view delegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let array = self.nodesArray {
            let json = array[indexPath.row]
            print(json)
            if let vc = storyboard?.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.nodeVC) as? CMNodeViewController {
                vc.nodeJSON = json
                whoCalledEditingViewController = indexPath.row
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension CMNodesCollectionViewController {
    
    // MARK: - perform GearRefreshControl
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        gearRefreshControl?.scrollViewDidScroll(scrollView)
        let delayInSeconds: Double = 3
        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * delayInSeconds))
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.gearRefreshControl?.endRefreshing()
            
        })
    
    }
    
    private func gearRefreshManager(){
        gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
        gearRefreshControl.gearTintColor = CUSTOM_THEME_COLOR.lighterColor(0.7)
        
        gearRefreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        
    }
       
    func refreshData(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            IBBSConfigureNodesInfo.sharedInstance.configureNodesInfo()
            self.nodesArray = IBBSConfigureNodesInfo.sharedInstance.nodesArray

            dispatch_async(dispatch_get_main_queue(), {
                self.collectionView?.reloadData()

            })
        })
    }
    
}

public class IBBSConfigureNodesInfo {
    
    static let sharedInstance = IBBSConfigureNodesInfo()
    private init(){}
    
    public var nodesArray: [JSON]?
    
    public func configureNodesInfo(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.getNodesIfNeeded()
            let nodes = CMContext.sharedInstance.getNodes()
            dispatch_async(dispatch_get_main_queue(), {
                if let json = nodes {
                    self.nodesArray = json.arrayValue
                } else {
                    self.configureNodesInfo()
                }
            })
        })
    }
    
    private func getNodesIfNeeded() {
        APIClient.sharedInstance.getNodes({ (json) -> Void in
            if json.type == Type.Array {
                self.nodesArray = json.arrayValue
                print(json.arrayValue)
                CMContext.sharedInstance.saveNodes(json.object)
            }
            }) { (error) -> Void in
                UIApplication.topMostViewController()?.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
                
        }
    }
}
