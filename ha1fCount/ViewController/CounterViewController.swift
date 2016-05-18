//
//  CounterViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4

class CounterViewController: CanvasController {
    
    let counter = ModelManager.manager.counter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.BACK_COLOR
        self.canvas.backgroundColor = Color(Constants.BACK_COLOR)
        srand(UInt32(time(nil)))
        counter.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        counter.delegate = self
        counter.forceReload()
    }
}

extension CounterViewController: CounterDelegate {
    func onCounterNumberChanged(old old: Int, new: Int) {
    }
}
