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
    
    static let COLOR_MOON = Color(UIColor.colorFromHex("ffff00", alpha: 1.0))
    static let COLOR_MOON_DARK = Shape().strokeColor!
    
    var moon: Arc!
    var darkMoon: Arc!
    var darkHalfMoon: Arc!
    
    let defaultCircleRadius: Double = 10
    
    var moonRadius: Double {
        return frame.width/4
    }
    
    override init(frame: Rect) {
        super.init(frame: frame)
        
        let center = Point(self.bounds.width/2, self.bounds.height/2)
        
        self.backgroundColor = MoonView.COLOR_MOON_DARK
        
        let radius = moonRadius
        
        // 右
        moon = Arc(center: center, radius: radius, start: -M_PI/2, end: M_PI/2)
        moon.fillColor = MoonView.COLOR_MOON
        moon.strokeColor = MoonView.COLOR_MOON
        moon.anchorPoint = Point(0.0, 0.5)
        self.add(moon)
        
        // 左
        darkHalfMoon = Arc(center: center, radius: radius, start: M_PI/2, end: M_PI*3/2)
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
        let center = Point(self.bounds.width/2, self.bounds.height/2)
        
        // なんとか倍率とかで計算できないか？(アニメーション)
        // cos(theta) = 0の時の処理(落ちる)
        
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
        
        let newMoon = Arc(center: Point((center.x + radius * cos(theta) - x), center.y), radius: x, start: -a, end: a)
        /*if cos(theta) > 0 {
            newMoon.anchorPoint = Point(-(x-radius*cos(theta))/(radius*cos(theta)), 0.5)
        } else {
            newMoon.anchorPoint = Point(1.0 + (x-radius*cos(theta))/(radius*cos(theta)), 0.5)
        }
        newMoon.center = Point((self.center.x + radius * cos(theta) - x), self.center.y)*/
        newMoon.fillColor = color
        newMoon.strokeColor = color
        
        /*ViewAnimation(duration: 0.5) {[weak self] _ in
            guard let `self` = self else {
                return
            }*/
            self.view.addSubview(newMoon.view)
            self.darkMoon?.view.removeFromSuperview()
            self.darkMoon = newMoon
        //}.animate()
    }
}
