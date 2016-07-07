//
//  CMWebVC.swift
//  Choume
//
//  Created by wang on 16/5/27.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import NJKWebViewProgress
import SVProgressHUD

class CMWebVC: UIViewController {
    
    private var content: String = ""
    private var url: NSURL?
    
    let proxy = NJKWebViewProgress()
    var progressView: NJKWebViewProgressView!

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        let navBounds = self.navigationController?.navigationBar.bounds
        progressView = NJKWebViewProgressView(frame: CGRectMake(0, (navBounds?.height)! - 2, (navBounds?.width)!, 2))
        //progressView.backgroundColor = UIColor.redColor()
        progressView.progressBarView.backgroundColor = theme.CMWebViewProgressBar
        progressView.setProgress(0, animated: true)
        progressView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        webView.delegate = proxy
        proxy.webViewProxyDelegate = self
        proxy.progressDelegate = self
        
        if self.content != "" {
            webView.loadHTMLString(self.content, baseURL: nil)
        }else if self.url != nil {
            webView.loadRequest(NSURLRequest(URL: self.url!))
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }else {
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, 200, 20))
            emptyLabel.font = UIFont.systemFontOfSize(15)
            emptyLabel.text = "404 :( 什么也没有"
            emptyLabel.textColor = UIColor.grayColor()
            emptyLabel.center = CGPoint(x: self.view.bounds.width / 2,
                                        y: self.view.bounds.height / 3)

            emptyLabel.textAlignment = .Center
        
            webView.addSubview(emptyLabel)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(progressView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        progressView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 加载html string 或 网络连接
    func  setContentOrUrl(content: String?, url: String?){
        if content != nil {
            self.content = content!
        }
        if url != nil && url != "" {
            self.url = NSURL(string: url!)
        }
    }
}

extension CMWebVC: UIWebViewDelegate, NJKWebViewProgressDelegate {
    func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        print(progress)
        progressView.setProgress(progress, animated: true)
        self.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        progressView.setProgress(1, animated: true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        progressView.setProgress(1, animated: true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        SVProgressHUD.showErrorWithStatus("加载失败", maskType: .Black)
    }
    
}
