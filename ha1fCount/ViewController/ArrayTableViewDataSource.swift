//
//  ArrayTableViewDataSource.swift
//  ha1fCount
//
//  Created by 山口智生 on 2016/05/17.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class ArrayTableViewDataSource<T>: NSObject, UITableViewDataSource {
    private let data: [T]
    private var cellInitializer: (T) -> UITableViewCell
    
    init(data: [T], cellInitializer: (T) -> UITableViewCell) {
        self.data = data
        self.cellInitializer = cellInitializer
    }
    
    func getDataAtIndex(index: Int) -> T {
        return data[index]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellInitializer(data[indexPath.row])
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
