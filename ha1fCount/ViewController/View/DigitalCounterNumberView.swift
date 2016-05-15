//
//  DigitalCounterView.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/13.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4

class DigitalCounterNumberView: CounterNumberView {
    
    var textShape: TextShape!
    
    override init(frame: Rect) {
        super.init(frame: frame)
        textShape = TextShape(text: "0")
        self.add(textShape)
    }

    override func updateView(newNumber: Int) {
        textShape.text = "\(newNumber)"
        textShape.center = self.bounds.center
    }

}
