//
//  Util.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/14.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class Util {
    static func getRandomInteger(min: Int, max: Int) -> Int {
        let r = Int(rand()) % (max - min + 1)
        return min + r
    }
}
