//
//  ViewController.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/13.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit
import Pulsator

class ViewController: CanvasController {
    
    let counter = ModelManager.manager.counter
    
    @IBOutlet weak var counterNumberContainerView: UIScrollView!
    @IBOutlet weak var counterButton: UIButton!
    
    var counterNumberViews: [CounterNumberView] = []
    
    var timer: NSTimer? = nil
    var pulsator: Pulsator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterNumberContainerView.contentSize = CGSizeMake(counterNumberContainerView.frame.width * 2, counterNumberContainerView.frame.height)
        counterNumberContainerView.delegate = self
        
        let v = Digital2CounterNumberView(frame: self.frameForPosition(0))
        counterNumberContainerView.add(v)
        counterNumberViews.append(v)
        
        let v2 = DigitalCounterNumberView(frame: self.frameForPosition(1))
        counterNumberContainerView.add(v2)
        counterNumberViews.append(v2)
        
        pulsator = Pulsator()
        pulsator.numPulse = 3
        pulsator.radius = 120.0
        pulsator.pulseInterval = 0.3
        pulsator.animationDuration = 3.0
        pulsator.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).CGColor
        pulsator.position = counterButton.center
        view.layer.addSublayer(pulsator)
        
        self.view.bringToFront(counterButton)
        
        counter.delegate = self
        counter.reset()
        
    }
    
    private func frameForPosition(i: Int) -> Rect {
        let width = Double(counterNumberContainerView.bounds.width)
        return Rect(Point(width * Double(i), 0.0), Size(counterNumberContainerView.bounds.size))
    }
    
    override func viewWillAppear(animated: Bool) {
        print("appear")
        if Settings.USE_TIMER {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.onUpdate), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
    func onUpdate() {
        counter.count()
    }
    
    @IBAction func onTappedClearButton(sender: AnyObject) {
        counter.reset()
    }
    
    @IBAction func onTappedCountButton(sender: AnyObject) {
        counter.count()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //let page = Int(scrollView.contentOffset.x / self.counterNumberContainerView.frame.width)
    }
}

extension ViewController: CounterDelegate {
    func onCounterNumberChanged(old old: Int, new: Int) {
        counterNumberViews.forEach { counterNumberView in
            counterNumberView.updateView(new)
        }
        
        if new > 0 {
            pulsator.stop()
        } else {
            pulsator.start()
        }
    }
}
