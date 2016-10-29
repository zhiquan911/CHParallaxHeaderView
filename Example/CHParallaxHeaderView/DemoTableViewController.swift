//
//  DemoTableViewController.swift
//  CHParallaxHeaderView
//
//  Created by 麦志泉 on 2016/10/18.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {

    @IBOutlet var imageViewHeader: UIView!
    @IBOutlet var imageViewLogo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "视差缩放View"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //添加缩放视差效果并跟踪着哪个View
        self.imageViewHeader.ch_addParallax(by: self.tableView)
        self.imageViewLogo.ch_addParallax(by: self.tableView, rate: 0.5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.imageViewHeader.ch_removeParallax()
        self.imageViewLogo.ch_removeParallax()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if indexPath.row % 2 == 0 {
            cell?.textLabel?.text = "TableView演示"
        } else {
            cell?.textLabel?.text = "WebView演示"
        }
        
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc: UIViewController
        if indexPath.row % 2 == 0 {
            //单数进入tableViewController
            vc = self.storyboard!.instantiateViewController(withIdentifier: "DemoTableViewController")
        } else {
            //双数进入webViewController
            vc = self.storyboard!.instantiateViewController(withIdentifier: "DemoWebViewController")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}


