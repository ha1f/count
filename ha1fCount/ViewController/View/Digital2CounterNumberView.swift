//
//  Digital2CounterNumberView.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/16.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import LTMorphingLabel

class Digital2CounterNumberView: CounterNumberView, LTMorphingLabelDelegate {
    
    var label: LTMorphingLabel!
    
    var currentNumber = 0
    
    var textColor: UIColor {
        set {
            self.label.textColor = newValue
        }
        get {
            return self.label.textColor
        }
    }
    
    override init(frame: Rect) {
        super.init(frame: frame)
        label = LTMorphingLabel(frame: CGRect(self.bounds))
        label.center = CGPoint(self.bounds.center)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.brownColor()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 80)
        self.add(label)
    }
    
    override func updateView(newNumber: Int) {
        label.text = "\(newNumber)"
        if newNumber == 0 && currentNumber != 1 && currentNumber != -1 {
            self.label.morphingDuration = 0.6
            self.label.morphingEffect = .Fall
        } else {
            if newNumber > currentNumber {
                // 増加
                self.label.morphingDuration = 0.6
                self.label.morphingEffect = .Evaporate
            } else {
                // 減少
                if newNumber == 0 {
                    self.label.morphingDuration = 1.5
                    self.label.morphingEffect = .Burn
                } else {
                    self.label.morphingDuration = 0.6
                    self.label.morphingEffect = .Anvil
                }
            }
        }
        currentNumber = newNumber
    }
    
}
