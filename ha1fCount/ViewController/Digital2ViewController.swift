//
//  Digital2ViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/16.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class Digital2ViewController: OriginalCounterViewController {
    
    var counterNumberView: CounterNumberView!
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        counterNumberView = Digital2CounterNumberView(frame: Rect(0, 50, width, width))
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
