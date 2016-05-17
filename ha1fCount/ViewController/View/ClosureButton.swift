//
//  ClosureButton.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/16.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class ClosureButton: UIButton {
    
    private(set) var touchUpMethod: ((ClosureButton) -> Void)?
    private(set) var touchDownMethod: ((ClosureButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.onTouchDown(_:)), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(self.onTouchUpInside(_:)), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tap() {
        onTouchDown(self)
        Util.dispatchAfter(0.1) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.onTouchUpInside(self)
        }
    }
    
    func dispatchOnTouchUpInside(closure: (ClosureButton) -> Void) -> ClosureButton {
        self.touchUpMethod = closure
        self.addTarget(self, action: #selector(self.onTouchUpInside(_:)), forControlEvents: .TouchUpInside)
        return self
    }
    
    func onTouchUpInside(button: ClosureButton!) {
        touchUpMethod?(button)
    }
    
    func onTouchDown(button: ClosureButton!) {
        touchDownMethod?(button)
    }
    
    func dispatchOnTouchDown(closure: (ClosureButton) -> Void) -> ClosureButton {
        self.touchDownMethod = closure
        return self
    }
    
}
