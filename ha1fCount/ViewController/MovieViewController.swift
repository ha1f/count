//
//  MovieViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import C4
import UIKit

class MovieViewController: OriginalCounterViewController {
    
    var counterNumberView: MovieCounterNumberView!
    
    override func loadView() {
        super.loadView()
        let width = Double(self.view.frame.width)
        
        counterNumberView = MovieCounterNumberView(frame: Rect(0, 50, width, width))
        counterNumberView.textShape.fillColor = darkGray
        counterNumberView.circle.strokeColor = darkGray
        self.view.add(counterNumberView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canvas.backgroundColor = lightGray
        
        clearButton.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func onCounterNumberChanged(old old: Int, new: Int) {
        super.onCounterNumberChanged(old: old, new: new)
        
        counterNumberView.updateView(new)
    }
}
