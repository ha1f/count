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
        self.label.morphingEffect = LTMorphingEffect.init(rawValue: Util.getRandomInteger(0, max: 4))!
    }
    
}
