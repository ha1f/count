//
//  SpringButton.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/16.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class SpringButton: ClosureButton {
    
    var animateDuration = 0.07
    
    override func onTouchDown(button: ClosureButton!) {
        UIView.animateWithDuration(animateDuration){ [weak self] _ in
            self?.transform = CGAffineTransformMakeScale(1.2, 1.2)
        }
        super.onTouchDown(button)
    }
    
    override func onTouchUpInside(button: ClosureButton!) {
        UIView.animateWithDuration(animateDuration){ [weak self] _ in
            self?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
        super.onTouchUpInside(button)
    }
}
