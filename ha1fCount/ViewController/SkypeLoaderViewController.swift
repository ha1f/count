//
//  SkypeLoaderViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class SkypeLoaderViewController: LikeCounterViewControllerWithoutPulsator {
    
    var counterNumberView: CounterNumberView!
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        let v = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        v.suffix = "%"
        v.textColor = UIColor.whiteColor()
        v.textFont = UIFont(name: "HelveticaNeue-Bold", size: 40)!
        counterNumberView = v
        self.view.add(counterNumberView)
        
        let skype = SkypeLoaderView()
        skype.center = counterNumberView.center
        self.view.add(skype)
        skype.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canvas.backgroundColor = SkypeLoaderView.COLOR_SKYPE
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
