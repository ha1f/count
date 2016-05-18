//
//  VerySimpleViewController.swift
//  ha1fCount
//
//  Created by はるふ on 2016/05/18.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class VerySimpleViewController: UIViewController {
    
    let counter = ModelManager.manager.counter
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter.delegate = self
        
        self.view.backgroundColor = Constants.BACK_COLOR
        
    }
    
    @IBAction func plus(sender: AnyObject) {
        counter.increment()
    }
}

extension VerySimpleViewController: CounterDelegate {
    func onCounterNumberChanged(old old: Int, new: Int) {
        label.text = "\(new)"
    }
}
