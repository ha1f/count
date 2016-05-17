//
//  Settings.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/15.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit


class Settings {
    static let USE_TIMER = false
    
    typealias SampleViewObject = (title: String, initializer: () -> UIViewController)
    
    static let samples: [SampleViewObject] = [
        ("colorful", {ColorfulCounterViewController()}),
        ("digital1", {DigitalNumberViewController()}),
        ("digital2", {Digital2ViewController()}),
        ("moon", {MoonViewController()}),
    ]
}
