//
//  LikeCounterViewControllerWithoutPulsator.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class LikeCounterViewControllerWithoutPulsator: CounterViewController {
    
    var counterButton: ClosureButton!
    
    override func loadView() {
        super.loadView()
        
        counterButton = SpringButton(frame: CGRectMake(0, 0, 94, 91)).dispatchOnTouchUpInside {[weak self] _ in
            self?.counter.increment()
        }
        counterButton.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 150)
        let likeImage = UIImage(named: "like.png")
        counterButton.setImage(likeImage, forState: .Normal)
        self.view.add(counterButton)
    }
}
