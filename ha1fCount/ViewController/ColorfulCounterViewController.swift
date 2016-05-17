//
//  ColorfulCounterViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class ColorfulCounterViewController: LikeCounterViewController {
    
    var circle: Circle!
    
    var counterNumberView: CounterNumberView!
    
    override func loadView() {
        super.loadView()
        
        let width = Double(self.view.frame.width)
        
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNewCircle()
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
        
        counterButton.userInteractionEnabled = false
        animateCircleWithCompletion {[weak self] _ in
            self?.counterButton.userInteractionEnabled = true
        }
    }
    
    private func createNewCircle() {
        self.circle?.removeFromSuperview()
        
        let circle = Circle(center: Point(counterButton.center), radius: 15)
        circle.fillColor = Util.randomColor()
        circle.strokeColor = circle.fillColor
        circle.transform = Transform.makeScale(1, 1)
        self.view.add(circle)
        self.view.sendToBack(circle)
        self.circle = circle
    }
    
    private func animateCircleWithCompletion(completion: (() -> ())?) {
        let scale = Double(self.view.frame.height + self.view.frame.width) / 15.0
        UIView.animateWithDuration(
            0.8,
            animations: {[weak self] _ in
                guard let `self` = self else {
                    return
                }
                self.circle?.transform = Transform.makeScale(scale, scale)
                if let v = self.counterNumberView as? Digital2CounterNumberView {
                    v.textColor = Util.reversedColor(UIColor(self.circle!.fillColor!)!)
                }
            },
            completion: {[weak self] _ in
                self?.view.backgroundColor = UIColor(self!.circle!.fillColor!)
                self?.createNewCircle()
                completion?()
            })
    }
    
}