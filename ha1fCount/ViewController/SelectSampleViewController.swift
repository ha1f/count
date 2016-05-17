//
//  ViewController.swift
//  C4Sample
//
//  Created by 山口智生 on 2016/04/25.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

class SelectSampleViewController: UIViewController {
    
    @IBOutlet weak var selectSampleTableView: UITableView!
    
    var dataSource: ArrayTableViewDataSource<Settings.SampleViewObject>!
    
    override func loadView() {
        super.loadView()
        
        dataSource = ArrayTableViewDataSource(data: Settings.samples, cellInitializer: {title, initializer in
            let cell = self.selectSampleTableView.dequeueReusableCellWithIdentifier("SelectSampleTableViewCell") as! SelectSampleTableViewCell
            cell.titleLabel.text = title
            return cell
        })
        
        selectSampleTableView.delegate = self
        selectSampleTableView.dataSource = dataSource
        selectSampleTableView.tableFooterView = UIView()
        selectSampleTableView.setContentOffset(CGPoint.zero, animated: false)
        selectSampleTableView.separatorColor = UIColor.lightGrayColor()
        self.view.addSubview(selectSampleTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Samples"
    }
}

extension SelectSampleViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let data = dataSource.getDataAtIndex(indexPath.row)
        let controller = data.initializer()
        controller.title = data.title
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
