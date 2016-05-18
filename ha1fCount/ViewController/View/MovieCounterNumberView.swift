//
//  MovieCounterNumberView.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4

class MovieCounterNumberView: CounterNumberView {
    var textShape: TextShape!
    var circle: Circle!
    
    override init(frame: Rect) {
        super.init(frame: frame)
        
        let center = Point(self.bounds.width/2, self.bounds.height/2)
        
        textShape = TextShape(text: "0")
        self.add(textShape)
        
        circle = Circle(center: center, radius: 70)
        circle.fillColor = clear
        circle.strokeColor = darkGray
        circle.lineWidth = 15
        circle.transform = Transform.makeRotation(M_PI/2)
        self.add(circle)
    }
    
    override func updateView(newNumber: Int) {
        textShape.text = "\(newNumber)"
        textShape.center = self.bounds.center
        
        
        let completion: () -> Void = {
            if self.circle.strokeEnd >= 1.0 && self.circle.strokeStart >= 1.0 {
                self.circle.strokeEnd = 0.0
                self.circle.strokeStart = 0.0
            }
        }
        
        // disappear end=1, start0->1
        // appear start=0, end=0->1
        let va: ViewAnimation
        if circle.strokeEnd < 0.5 {
            va = ViewAnimation(duration: 0.95) {[weak self] _ in
                self?.circle.strokeEnd = 1.0
            }
        } else {
            va = ViewAnimation(duration: 0.95) {[weak self] _ in
                self?.circle.strokeStart = 1.0
            }
        }
        va.addCompletionObserver(completion)
        va.animate()
    }
}
