//
//  ViewController.swift
//  CHParallaxHeaderView
//
//  Created by 麦志泉 on 10/17/2016.
//  Copyright (c) 2016 麦志泉. All rights reserved.
//

import UIKit
import CHParallaxHeaderView

class DemoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var userHeaderView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageViewHeader: UIView!
    @IBOutlet var imageViewLogo: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "渐变NavBar"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UIColor(white: 1, alpha: 1)
        //添加渐变效果并跟踪着哪个View
        self.navigationController?.navigationBar.ch_addGradient(by: self.tableView,
                                                                barColor: color)
        
        //添加缩放视差效果并跟踪着哪个View
        self.imageViewHeader.ch_addParallax(by: self.tableView)
//        self.imageViewLogo.ch_addParallax(by: self.tableView, rate: 0.5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //当控制器是消失时，把绑定的跟踪移除
        self.navigationController?.navigationBar.ch_removeGradient()
        self.imageViewHeader.ch_removeParallax()
//        self.imageViewLogo.ch_removeParallax()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        cell?.textLabel?.text = "Hello world"
        
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NSLog("scrollViewDidScroll")
    }
    
}

