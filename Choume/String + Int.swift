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
}

extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

extension UInt64 {
    var stringValue:String {
        return "\(self)"
    }
}