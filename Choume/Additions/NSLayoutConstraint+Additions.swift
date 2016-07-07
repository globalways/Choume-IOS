//
//  NSLayoutConstraint+Additions.swift
//  Choume
//
//  Created by wang on 16/5/31.
//  Copyright © 2016年 outsouring. All rights reserved.
//

// http://stackoverflow.com/questions/11664115/unable-to-simultaneously-satisfy-constraints-will-attempt-to-recover-by-breakin

import Foundation

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}