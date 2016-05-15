//
//  Counter.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/13.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import Foundation

protocol CounterDelegate {
    func onCounterNumberChanged(old old: Int, new: Int)
}

class Counter: NSObject {
    private(set) var number = 0 {
        didSet {
            delegate?.onCounterNumberChanged(old: oldValue, new: number)
        }
    }
    
    var delegate: CounterDelegate? = nil
    
    func add(n: Int) {
        number += n
    }
    
    func count() {
        number += 1
    }
    
    func reset() {
        number = 0
    }
    
}
