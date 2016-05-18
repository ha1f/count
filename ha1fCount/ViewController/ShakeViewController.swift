//
//  ShakeViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import CoreMotion

class ShakeViewController: CounterViewController {
    
    var counterNumberView: CounterNumberView!
    
    let motionManager = CMMotionManager()
    var preData = CMAcceleration(x: 0, y: 0, z: 0)
    
    var shakeMargin = 0
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.motionManager.accelerometerUpdateInterval = 0.2
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
            (data, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.updateAccelerationData(data!.acceleration)
            }
        }
    }
    
    func updateAccelerationData(data: CMAcceleration) {
        
        let diff = pow(data.x-preData.x, 2) + pow(data.y-preData.y, 2) + pow(data.z-preData.z, 2)
        
        let isShaken: Bool = diff > 1
        
        if isShaken && shakeMargin <= 0 {
            counter.increment()
            shakeMargin = 3
        }
        if shakeMargin > 0 {
            shakeMargin -= 1
        }
        
        preData = data
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
