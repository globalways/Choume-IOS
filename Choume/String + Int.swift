//
//  String + Int.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/21.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double? {
        return Double(self)
    }
    var floatValue: Float? {
        return Float(self)
    }
    var integerValue: Int? {
        return Int(self)
    }
    var int64Value: Int64? {
        return Int64(self)
    }
    var uint64Value: UInt64? {
        return UInt64(self)
    }
    
    ///The ?? nil coalescing operator returns the left side if it's non-nil, otherwise it returns the right side.这个方法有问题，暂不使用
    func isCMEmpty() -> Bool{
        //return self == nil || self == ""
        return true
    }
}

extension Int {
    var stringValue:String {
        return "\(self)"
    }
    func niltozero() -> Int {
        return (self ?? 0)
    }
}

extension UInt64 {
    var stringValue:String {
        return "\(self)"
    }
}