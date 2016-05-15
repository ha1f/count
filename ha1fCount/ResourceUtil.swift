//
//  ResourceUtil.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/15.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

protocol ResourceInstantiatable {
    associatedtype InstanceType
    func instantiate() -> InstanceType
    func instantiate(configure: (InstanceType -> Void)?) -> InstanceType
}

extension ResourceInstantiatable {
    func instantiate(configure: (InstanceType -> Void)?) -> InstanceType {
        let instance = instantiate()
        configure?(instance)
        return instance
    }
}

struct Storyboard<T: UIViewController>: ResourceInstantiatable {
    typealias InstanceType = T
    
    let name: String
    let identifier: String?
    
    func instantiate() -> InstanceType {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let identifier = identifier {
            return storyboard.instantiateViewControllerWithIdentifier(identifier) as! InstanceType
        } else {
            return storyboard.instantiateInitialViewController() as! InstanceType
        }
    }
    
    init(name: String, identifier: String? = nil) {
        self.name = name
        self.identifier = identifier
    }
}

struct Nib<T: UIView>: ResourceInstantiatable {
    typealias InstanceType = T
    
    let name: String
    
    func instantiate() -> InstanceType {
        let nib = UINib(nibName: name, bundle: nil)
        return nib.instantiateWithOwner(nil, options: nil).first as! InstanceType
    }
    
    init(name: String) {
        self.name = name
    }
}
