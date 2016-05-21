//
//  MoonViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class MoonViewController: LikeCounterViewControllerWithoutPulsator {
    
    var counterNumberView: CounterNumberView!
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        counterNumberView = MoonView(frame: Rect(0, 50, width, width))
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvas.backgroundColor = MoonView.COLOR_MOON_DARK
        
        counterButton.setImage(UIImage(named: "tsukimi_dango"), forState: .Normal)
        counterButton.imageView?.contentMode = .ScaleAspectFit
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
