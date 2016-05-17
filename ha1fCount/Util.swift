//
//  Util.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/14.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit
import C4

extension UIColor {
    static func colorFromHex(hexString: String, alpha: CGFloat) -> UIColor {
        let normalizedString = hexString.hasPrefix("#") ? hexString.substringFromIndex(hexString.startIndex.successor()) : hexString
        
        if let value = Util.scanHexToInt(normalizedString) {
            let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((value & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(value & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor()
        }
    }
}

class Util {
    static func scanHexToInt(string: String) -> Int? {
        let scanner = NSScanner(string: string)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            return Int(color)
        } else {
            return nil
        }
    }
    
    static func randomInteger(min: Int, max: Int) -> Int {
        let r = Int(rand()) % (max - min + 1)
        return min + r
    }
    
    static func randomDouble() -> Double {
        return Double(rand())/Double(INT32_MAX)
    }
    
    static func randomColor() -> Color {
        return Color(red: Util.randomDouble(), green: Util.randomDouble(), blue: Util.randomDouble(), alpha: 1.0)
    }
    
    static func randomUIColor() -> UIColor {
        return UIColor(randomColor())!
    }
    
    static func reversedColor(color: UIColor) -> UIColor {
        var h: CGFloat = 0.0, s: CGFloat = 0.0, v: CGFloat = 0.0, alpha: CGFloat = 0.0
        color.getHue(&h, saturation: &s, brightness: &v, alpha: &alpha)
        if h > 0.5 {
            h -= 0.5
        } else {
            h += 0.5
        }
        return UIColor(hue: h, saturation: s, brightness: v, alpha: alpha)
    }
    
    static func dispatchAfter(seconds: Double, process: () -> ()) {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64( seconds * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) { _ in
            process()
        }
    }
    
}
