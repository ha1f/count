//
//  LikeCounterViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit
import Pulsator

class LikeCounterViewController: LikeCounterViewControllerWithoutPulsator {

    var pulsator: Pulsator!
    
    override func loadView() {
        super.loadView()
        
        pulsator = Pulsator()
        pulsator.numPulse = 3
        pulsator.radius = 100.0
        pulsator.pulseInterval = 0.1
        pulsator.animationDuration = 3.0
        pulsator.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).CGColor
        pulsator.position = counterButton.center
        view.layer.addSublayer(pulsator)
        
        self.view.bringToFront(counterButton)
        
        self.view.backgroundColor = Constants.BACK_COLOR
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        srand(UInt32(time(nil)))
        
        counter.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        counter.delegate = self
        counter.forceReload()
    }
 
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        if new > 0 {
            pulsator.stop()
        } else {
            pulsator.start()
        }
    }
}
