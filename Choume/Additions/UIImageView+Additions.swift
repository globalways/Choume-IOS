//
//  UIImageView+Additions.swift
//  iBBS
//
//  Created by Augus on 10/11/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation


extension UIImageView {
    
    func changeColorForImageOfImageView(tintColor: UIColor) {
        self.image = self.image?.imageWithRenderingMode(.AlwaysTemplate)
        self.tintColor = tintColor
    }
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    
}