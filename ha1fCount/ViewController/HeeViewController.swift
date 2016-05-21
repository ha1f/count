//
//  HeeViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/22.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit
import AVFoundation

class HeeViewController: LikeCounterViewControllerWithoutPulsator {
    var counterNumberView: Digital2CounterNumberView!
    
    var player: AVPlayer!
    
    override func loadView() {
        super.loadView()
        
        let width = Double(self.view.frame.width)
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        counterNumberView.textColor = UIColor.cyanColor()
        counterNumberView.suffix = " へぇ"
        
        player = AVPlayer(playerItem: AVPlayerItem(asset: AVAsset(URL: NSBundle.mainBundle().URLForResource("hee", withExtension: "mp3")!)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = Color(FacebookViewController.COLOR_FACEBOOK)
        self.view.add(counterNumberView)
        
        counterButton.setImage(UIImage(named: "hee.png"), forState: .Normal)
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        if new != 0 {
            player.seekToTime(CMTime(seconds: 0, preferredTimescale: 1))
            player.play()
        }
        counterNumberView.updateView(new)
    }
}