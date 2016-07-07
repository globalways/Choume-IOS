//
//  CMLoadingScreenVC.swift
//  Choume
//
//  Created by wang on 16/5/24.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMLoadingScreenVC: UIViewController {
    
    // init loading view
    private var spinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let loadingLabel = UILabel()
    
    // Set the activity indicator into the main view
    func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.view.frame.width / 2) - (width / 2)
        let y = (self.view.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRectMake(x, y, width, height)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.grayColor()
        self.loadingLabel.textAlignment = NSTextAlignment.Center
        self.loadingLabel.text = "正在加载..."
        self.loadingLabel.frame = CGRectMake(0, 0, 140, 30)
        self.loadingLabel.hidden = false
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.spinner.frame = CGRectMake(0, 0, 30, 30)
        self.spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        
        self.view.addSubview(loadingView)
    }
    
    
    // Remove the activity indicator from the main view
    func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
    
    func removeLoadingScreen(timer: NSDate) {
        Tool.uiHalfSec(timer) {
            self.removeLoadingScreen()
        }
    }
    
    func loadingScreenText(info: String) {
        self.spinner.stopAnimating()
        self.loadingLabel.text = info
    }
    
}
