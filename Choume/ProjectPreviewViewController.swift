//
//  ProjectPreviewViewController.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/28.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat = 35

class ProjectPreviewViewController: UIViewController, DoubleTextViewDelegate {

    var projectNameStr: String?
    private var fourImageLabelView: FourImageLabelView!
    private var bottomScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    private var albumTableView: MainTableView!
    private var dayTableView: MainTableView!
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDesc: UILabel!
    @IBOutlet weak var projectMore: UILabel!
    @IBOutlet weak var projectUserAvatar: UIImageView!
    @IBOutlet weak var projectProgressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        
        projectName.text = projectNameStr
        
        setHorizontalViews()
        
        setScrollViewNav()
        setScrollView()
        setdayTableView()
        setalbumTableView()
        navigationItem.title = projectNameStr
        
        dayTableView.reloadData()
        albumTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
    }
    
    func setHorizontalViews() {
        var texts = ["众筹进度","已筹金额(元)","已筹物品(件)","剩余时间"]
        var images = ["Icon-Percent","Icon-Percent","Icon-Time","Icon-Time"]
        fourImageLabelView = FourImageLabelView(texts: texts, images: images)
        fourImageLabelView.frame = CGRectMake(0, 300, self.view.width, 50)
        view.addSubview(fourImageLabelView)
        let divider2: UIView = UIView()
        divider2.frame = CGRectMake(0, 360, AppWidth, 9)
        divider2.backgroundColor = theme.CMGrayLight
        view.addSubview(divider2)
        
    }
    
    private func setScrollViewNav() {
        doubleTextView = DoubleTextView(leftText: "参  与", rigthText: "评  论", centerText: "支持者");
        doubleTextView.frame = CGRectMake(0, 370, self.view.width, 44)
        doubleTextView.delegate = self
        view.addSubview(doubleTextView)
    }
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        bottomScrollView = UIScrollView(frame: CGRectMake(0, 414, AppWidth, AppHeight - 414))
        bottomScrollView.backgroundColor = theme.SDBackgroundColor
        bottomScrollView.contentSize = CGSizeMake(AppWidth * 2.0, 0)
        bottomScrollView.showsHorizontalScrollIndicator = false
        bottomScrollView.showsVerticalScrollIndicator = false
        bottomScrollView.pagingEnabled = true
        bottomScrollView.delegate = self
        view.addSubview(bottomScrollView)
    }
    
    private func setdayTableView() {
        dayTableView = MainTableView(frame: CGRectMake(0, 0, AppWidth, bottomScrollView.height), style: .Grouped, dataSource: self, delegate: self)
        dayTableView.sectionHeaderHeight = 0.1
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0)
        dayTableView.backgroundColor = UIColor.whiteColor()
        bottomScrollView.addSubview(dayTableView)
        //setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    
    
    private func setalbumTableView() {
        albumTableView = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, bottomScrollView.height), style: .Plain, dataSource: self, delegate: self)
        bottomScrollView.addSubview(albumTableView)
        
        //setTableViewHeader(self, refreshingAction: "pullLoadAlbumData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: albumTableView)
    }

//    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
//        let header = SDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
//        header.gifView!.frame = imageFrame
//        tableView.header = header
//    }
    
    
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        bottomScrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(index), 0), animated: true)
    }

}

/// MARK: UIScrollViewDelegate
extension ProjectPreviewViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === bottomScrollView {
            let index = Int(scrollView.contentOffset.x / AppWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}

///MARK:- UITableViewDelegate和UITableViewDataSource
extension ProjectPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //注册xib
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.joinProjectCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.joinProjectCell)
        if tableView === albumTableView {
            return 5
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === albumTableView {
            return 240
        } else {
            if indexPath.row == 1 {
                return 220
            } else {
                return 250
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === albumTableView {
            return 5
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView === albumTableView {
            cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.joinProjectCell) as! JoinProjectCell
        }else {
            
            cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.joinProjectCell) as! JoinProjectCell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("cell selected")
    }
}
