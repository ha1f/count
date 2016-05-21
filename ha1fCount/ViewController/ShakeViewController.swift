//
//  ShakeViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit
import CoreMotion
import AVFoundation

class ShakeViewController: CounterViewController {
    
    var counterNumberView: CounterNumberView!
    
    var backView: UIImageView!
    
    let motionManager = CMMotionManager()
    var preData: CMAcceleration!
    
    var player: AVPlayer!
    
    var shakeMargin = 0
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVPlayer(playerItem: AVPlayerItem(asset: AVAsset(URL: NSBundle.mainBundle().URLForResource("Taylor Swift-Shake It Off", withExtension: "mp3")!)))
        player.play()
        
        self.motionManager.accelerometerUpdateInterval = 0.2
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.motionManager.stopAccelerometerUpdates()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {[weak self]
            (data, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self?.updateAccelerationData(data!.acceleration)
            }
        }
    }
    
    func updateAccelerationData(data: CMAcceleration) {
        guard let preData = preData else {
            self.preData = data
            return
        }
        
        let diff = pow(data.x-preData.x, 2) + pow(data.y-preData.y, 2) + pow(data.z-preData.z, 2)
        
        let isShaken: Bool = diff > 1
        
        if isShaken && shakeMargin <= 0 {
            counter.increment()
            shakeMargin = 4
        }
        if shakeMargin > 0 {
            shakeMargin -= 1
        }
        
        self.preData = data
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
