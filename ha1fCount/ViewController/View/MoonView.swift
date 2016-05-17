//
//  MoonView.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class MoonView: CounterNumberView {
    
    static let COLOR_MOON = Color(UIColor.colorFromHex("000000", alpha: 1.0))
    static let COLOR_MOON_DARK = Color(Constants.BACK_COLOR)
    
    var moon: Arc!
    var darkMoon: Arc!
    var darkHalfMoon: Arc!
    
    var moonRadius: Double {
        return frame.width/4
    }
    
    override init(frame: Rect) {
        super.init(frame: frame)
        
        let radius = moonRadius
        
        // 右
        moon = Arc(center: self.center, radius: radius, start: -M_PI/2, end: M_PI/2)
        moon.fillColor = MoonView.COLOR_MOON
        moon.strokeColor = MoonView.COLOR_MOON
        moon.anchorPoint = Point(0.0, 0.5)
        self.add(moon)
        
        // 左
        darkHalfMoon = Arc(center: self.center, radius: radius, start: M_PI/2, end: M_PI*3/2)
        darkHalfMoon.fillColor = MoonView.COLOR_MOON_DARK
        darkHalfMoon.strokeColor = MoonView.COLOR_MOON_DARK
        darkHalfMoon.anchorPoint = Point(1.0, 0.5)
        self.add(darkHalfMoon)
        
        let theta = 2 * M_PI * Double(0%30) / 30
        let x = radius / 2 * (1.0 / cos(theta) + cos(theta))
        
        let a = asin(radius / x)
        
        darkMoon = Arc(center: Point((self.center.x + radius * cos(theta) - x), self.center.y), radius: x, start: -a, end: a)
        darkMoon.fillColor = MoonView.COLOR_MOON
        darkMoon.strokeColor = MoonView.COLOR_MOON
        self.add(darkMoon)
    }
    
    override func updateView(newNumber: Int) {
        let radius = moonRadius
        
        // なんとか倍率とかで計算できないか？(アニメーション)
        
        let color: Color
        var theta = 2 * M_PI * Double(newNumber%30) / 30
        if theta > M_PI {
            if theta > M_PI*3/2 {
                color = MoonView.COLOR_MOON_DARK
            } else {
                color = MoonView.COLOR_MOON
            }
            darkHalfMoon.transform = Transform.makeRotation(M_PI)
            moon.transform = Transform.makeRotation(M_PI)
            // 反転
            theta -= M_PI
        } else {
            if theta >= M_PI/2 && theta <= M_PI*3/2 {
                color = MoonView.COLOR_MOON
            } else {
                color = MoonView.COLOR_MOON_DARK
            }
            darkHalfMoon.transform = Transform.makeRotation(0)
            moon.transform = Transform.makeRotation(0)
        }
        
        let x = radius / 2 * (1.0 / cos(theta) + cos(theta))
        let a = asin(radius / x)
        
        let newMoon = Arc(center: Point((self.center.x + radius * cos(theta) - x), self.center.y), radius: x, start: -a, end: a)
        
        newMoon.fillColor = color
        newMoon.strokeColor = color
        
        ShapeLayer.disableActions = true
        self.darkMoon?.removeFromSuperview()
        self.darkMoon = newMoon
        self.add(newMoon)
        ShapeLayer.disableActions = false
    }
}
