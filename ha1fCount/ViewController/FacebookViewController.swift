//
//  FacebookViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/22.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit
import C4

class FacebookViewController: LikeCounterViewController {
    
    static let COLOR_FACEBOOK = UIColor.colorFromHex("#3B5998", alpha: 1.0)
    
    var counterNumberView: Digital2CounterNumberView!
    
    override func loadView() {
        super.loadView()
        
        let width = Double(self.view.frame.width)
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        counterNumberView.textColor = UIColor(white)!
        counterNumberView.suffix = " likes"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = Color(FacebookViewController.COLOR_FACEBOOK)
        self.view.add(counterNumberView)
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
