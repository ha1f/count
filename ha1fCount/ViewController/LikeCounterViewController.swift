//
//  LikeCounterViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit
import Pulsator

class LikeCounterViewController: CanvasController {
    
    let counter = ModelManager.manager.counter
    
    var counterButton: ClosureButton!

    var pulsator: Pulsator!
    
    override func loadView() {
        super.loadView()
        
        counterButton = SpringButton(frame: CGRectMake(0, 0, 94, 91)).dispatchOnTouchUpInside {[weak self] _ in
            self?.counter.increment()
        }
        counterButton.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 150)
        let likeImage = UIImage(named: "like.png")
        counterButton.setImage(likeImage, forState: .Normal)
        self.view.add(counterButton)
        
        pulsator = Pulsator()
        pulsator.numPulse = 3
        pulsator.radius = 100.0
        pulsator.pulseInterval = 0.1
        pulsator.animationDuration = 3.0
        pulsator.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).CGColor
        pulsator.position = counterButton.center
        view.layer.addSublayer(pulsator)
        
        self.view.bringToFront(counterButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.BACK_COLOR
        
        srand(UInt32(time(nil)))
        
        counter.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        counter.delegate = self
        counter.forceReload()
    }
    
}

extension LikeCounterViewController: CounterDelegate {
    func onCounterNumberChanged(old old: Int, new: Int) {
        if new > 0 {
            pulsator.stop()
        } else {
            pulsator.start()
        }
    }
}