//
//  SkypeLoaderView.swift
//  C4Sample
//
//  Created by 山口智生 on 2016/05/03.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4

// anchorPoint=中心となる座標
/*
 containerの上に4つのview、各viewの上にcircle
 containerはLinearな回転を続ける(durationで一周)
 containerの上で、viewが更に回る、circleは拡大・縮小する
 */
class SkypeLoaderView: View {
    private var views = [View]()
    private var circles = [Circle]()
    private var container: View!
    
    private let duration = 3.0
    private var viewAnimationGroup: ViewAnimationGroup!
    private var circleAnimationGroup: ViewAnimationGroup!
    private var containerAnimation: ViewAnimation!
    
    private var animationTimer: Timer?
    
    static let COLOR_SKYPE = Color(red: 64, green: 177, blue: 239, alpha: 1.0)
    
    override init() {
        super.init()
        
        backgroundColor = SkypeLoaderView.COLOR_SKYPE
        
        createViewsCircles()
        createAnimations()
        
        animationTimer = Timer(interval: duration/4.0) {[weak self] _ in
            if let `self` = self {
                self.viewAnimationGroup.animate()
                self.circleAnimationGroup.animate()
            }
        }
        startAnimating()
        
        containerAnimation = ViewAnimation(duration: duration) { _ in
            self.container.rotation += 2*M_PI
        }
        containerAnimation.curve = .Linear
        containerAnimation.repeats = true
        containerAnimation.animate()
    }
    
    func startAnimating() {
        animationTimer?.start()
        animationTimer?.fire()
    }
    
    func stopAnimating() {
        animationTimer?.pause()
    }
    
    private func createViewsCircles() {
        container = View(frame: Rect(0, 0, 160, 160))
        container.backgroundColor = clear
        let circleRadius = 5.0
        for _ in 0..<4 {
            let v = View(frame: Rect(0, 0, circleRadius*2, circleRadius*2))
            views.append(v)
            
            let c = Circle(center: Point(circleRadius, circleRadius), radius: circleRadius)
            c.lineWidth = 10.0
            c.strokeColor = white
            c.fillColor = white
            circles.append(c)
            
            v.add(c)
            // 中心から、yで上にheightの7倍進んだとこを回転、座標セットの中心に(今後の座標セット・回転はココが中心になる)
            v.anchorPoint = Point(0.5, 7.5)
            v.center = container.center
            container.add(v)
        }
        add(container)
        container.center = self.center
    }
    
    private func createAnimations() {
        let vanimDuration = duration/4.0 + 0.3
        
        let vanims: [ViewAnimation] = views.enumerate().map { (i, view) in
            let offset = Double(i) * 0.1 + 0.05
            let va = ViewAnimation(duration: vanimDuration) {
                view.rotation += M_PI
            }
            va.delay = offset
            return va
        }
        
        let canims: [ViewAnimation] = circles.enumerate().map { (i, circle) in
            let offset = Double(i) * 0.1 + 0.05
            
            let canim = ViewAnimation(duration: vanimDuration/2.0) {
                circle.lineWidth = 0.0
            }
            canim.delay = offset
            canim.autoreverses = true
            canim.addCompletionObserver {
                ShapeLayer.disableActions = true
                circle.lineWidth = 10.0
                ShapeLayer.disableActions = false
            }
            return canim
        }
        viewAnimationGroup = ViewAnimationGroup(animations: vanims)
        circleAnimationGroup = ViewAnimationGroup(animations: canims)
    }
}
