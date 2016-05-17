//
//  OriginalCounterViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/16.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class OriginalCounterViewController: LikeCounterViewController {
    
    var decreaseButton: ClosureButton!
    var clearButton: ClosureButton!
    var timerButton: ClosureButton!
    
    //var circle: Circle!
    
    var timer: NSTimer? = nil
    
    override func loadView() {
        super.loadView()
        
        decreaseButton = SpringButton(frame: CGRectMake(0, 0, 94/2, 91/2)).dispatchOnTouchUpInside {[weak self] _ in
            self?.counter.decrement()
        }
        decreaseButton.center = CGPoint(x: self.view.frame.width - 70, y: self.view.frame.height - 130)
        let dislikeImage = UIImage(named: "dislike.png")
        decreaseButton.setImage(dislikeImage, forState: .Normal)
        self.view.add(decreaseButton)
        
        clearButton = SpringButton(frame: CGRectMake(0, 0, 94/2, 91/2)).dispatchOnTouchUpInside {[weak self] _ in
            self?.counter.reset()
        }
        clearButton.center = CGPoint(x: 70, y: self.view.frame.height - 130)
        clearButton.setTitle("reset", forState: .Normal)
        clearButton.setTitleColor(Constants.KEY_COLOR, forState: .Normal)
        self.view.add(clearButton)
        
        timerButton = SpringButton(frame: CGRectMake(0, 0, 70, 30)).dispatchOnTouchUpInside {[weak self] _ in
            guard let `self` = self else {
                return
            }
            
            if self.counter.number > 0 {
                self.createCountdownTimer()
            } else {
                self.createCountupTimer()
            }
        }
        timerButton.center = CGPoint(x: self.view.frame.width - 70, y: self.view.frame.height - 60)
        timerButton.setTitle("timer", forState: .Normal)
        timerButton.setTitleColor(Constants.KEY_COLOR, forState: .Normal)
        self.view.add(timerButton)
        
        self.view.bringToFront(counterButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Settings.USE_TIMER {
            createCountupTimer()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
    func createCountdownTimer() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.onCountDown), userInfo: nil, repeats: true)
    }
    
    func createCountupTimer() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.onCountUp), userInfo: nil, repeats: true)
    }
    
    func onCountDown() {
        decreaseButton.tap()
    }
    
    func onCountUp() {
        counterButton.tap()
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        if new == 0 {
            timer?.invalidate()
        }
    }
    
}
