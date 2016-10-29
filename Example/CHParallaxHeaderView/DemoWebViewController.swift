//
//  DemoWebViewController.swift
//  CHParallaxHeaderView
//
//  Created by 麦志泉 on 2016/10/29.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class DemoWebViewController: UIViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var imageViewHeader: UIView!
    @IBOutlet var imageViewLogo: UIView!
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加扩展头部
        self.webView.ch_addHeaderView(headerView: self.headerView)
        
        self.loadHtml()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let color = UIColor(white: 1, alpha: 1)
        //添加渐变效果并跟踪着哪个View
        self.navigationController?.navigationBar.ch_addGradient(by: self.webView.scrollView,
                                                                barColor: color)
        
        
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //当控制器是消失时，把绑定的跟踪移除
        self.navigationController?.navigationBar.ch_removeGradient()
        self.imageViewHeader.ch_removeParallax()
    }
    

    /**
     加载html页面
     */
    func loadHtml() {
        let url = "https://www.chbtc.com/mobile/download"
        let request: URLRequest = URLRequest(url: URL(string: url)!)
        self.webView.loadRequest(request)
        
    }

}

extension DemoWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //iOS10 bug，如果webview，要在这回调中绑定，不然会初始化话时，头部向上偏移
        self.imageViewHeader.ch_addParallax(by: self.webView.scrollView)

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
 
    }
}
