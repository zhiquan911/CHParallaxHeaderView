//
//  CHParallaxHeaderViewExtension.swift
//  Pods
//
//  Created by 麦志泉 on 2016/10/17.
//
//

import Foundation

// MARK: - 扩展UIView，增开绑定ScrollView控制UIView视差缩放
extension UIView {
    
    
    /**************** 通过AssociatedKeys的值定义成员变量 ****************/
    
    //在扩展中通过key来定义成员变量
    fileprivate struct AssociatedKeys {
        static var ch_fixFrame = "ch_fixFrame"
        static var ch_parallaxRate = "ch_parallaxRate"
        static var ch_scrollView = "ch_scrollView"
    }
    
    var ch_scrollView: UIScrollView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ch_scrollView) as? UIScrollView
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.ch_scrollView,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    //固定时的位置及大小
    var ch_fixFrame: CGRect {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ch_fixFrame) as! CGRect
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.ch_fixFrame,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    //视差比率
    var ch_parallaxRate: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ch_parallaxRate) as! CGFloat
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.ch_parallaxRate,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    
    /**************** 扩展方法 ****************/
    
    
    /// 添加视差控制
    ///
    /// - parameter scrollView: 关联的滚动视图
    /// - parameter rate:       视差比例，提供 -2 ~ 2范围缩放
    public func ch_addParallax(by scrollView: UIScrollView, rate: CGFloat = 1) {
        self.ch_controller()?.view.layoutIfNeeded()
        //记录原来固定的宽高值
        self.ch_fixFrame = self.frame
        
        if rate > 2 {
            self.ch_parallaxRate = 2
        } else if rate < -2 {
            self.ch_parallaxRate = -2
        } else {
            self.ch_parallaxRate = rate
        }
        
        
        if self.ch_scrollView == nil {
            //添加监听
            self.ch_scrollView = scrollView
            scrollView.addObserver(self,
                                   forKeyPath: "contentOffset",
                                   options: [.new, .old],
                                   context: nil)
        }
    }
    
    public func ch_removeParallax() {
        if let scrollView = self.ch_scrollView {
            scrollView.removeObserver(self, forKeyPath: "contentOffset")
            self.ch_scrollView = nil
        }
    }
    
    /// 监听回调
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == "contentOffset" {
            let scrollView = object as! UIScrollView
            self.ch_parallaxForScrollViewOffset(offset: scrollView.contentOffset)
        }
        
    }
    
    
    /// 视差效果跟踪
    ///
    /// - parameter offset:
    func ch_parallaxForScrollViewOffset(offset: CGPoint) {
        let offsetY = offset.y
        //放大视差效果
        if offsetY < 0 {
            var delta: CGFloat = 0.0
            delta = fabs(min(0.0, offsetY)) *  self.ch_parallaxRate
            var rect = self.ch_fixFrame
            
            rect.size.height += delta
            rect.size.width *= rect.size.height / self.ch_fixFrame.size.height
            rect.origin.x -= (rect.size.width - self.ch_fixFrame.size.width) / 2
            rect.origin.y -= delta
            self.frame = rect
            self.clipsToBounds = true
        } else {
            self.frame = self.ch_fixFrame
            self.clipsToBounds = true
        }
        //NSLog("self.ch_fixFrame = \(self.ch_fixFrame)")
    }
    
    
    /// 寻找View所属的controller
    ///
    /// - returns:
    func ch_controller() -> UIViewController? {
        var father = self.superview
        while father != nil {
            if let nextResponder = father?.next, nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            father = father?.superview
        }
        return nil
    }
    
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//        self.layoutIfNeeded()
//    }
}

// MARK: - 扩展UINavigationBar，增开绑定ScrollView控制导航栏渐变
extension UINavigationBar {
    
    /**************** 通过AssociatedKeys的值定义成员变量 ****************/
    
    //在扩展中通过key来定义成员变量
    fileprivate struct AssociatedKeys {
        static var ch_overlay = "ch_overlay"
    }
    
    //通过AssociatedKeys的值定义成员变量
    var ch_overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ch_overlay) as? UIView
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.ch_overlay,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    
    /**************** 扩展方法 ****************/
    
    
    public func ch_addGradient(by scrollView: UIScrollView, barColor: UIColor) {
        self.barTintColor = barColor
        
        if self.ch_scrollView == nil {
            //添加监听
            self.ch_scrollView = scrollView
            scrollView.addObserver(self,
                                   forKeyPath: "contentOffset",
                                   options: [.new, .old],
                                   context: nil)
        }
        
        //马上滚动一下
        scrollView.contentOffset.y = scrollView.contentOffset.y
        
        
    }
    
    /// 监听回调
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //NSLog("offchangeset = \(change)")
        if let keyPath = keyPath, keyPath == "contentOffset" {
            let scrollView = object as! UIScrollView
            self.ch_gradientBarColorForScrollViewOffset(offset: scrollView.contentOffset)
        }
    }
    
    /// 重置bar背景颜色
    public func ch_removeGradient() {
        if let scrollView = self.ch_scrollView {
            scrollView.removeObserver(self, forKeyPath: "contentOffset")
            self.ch_scrollView = nil
        }
        self.ch_removeBackgroundColor()
    }
    
    /**
     设置导航栏背景颜色
     
     - parameter backgroundColor:
     */
    func ch_setBackgroundColor(_ backgroundColor: UIColor) {
        if self.ch_overlay == nil {
            //创建一个背景层
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = UIImage()
            self.ch_overlay = UIView(frame: CGRect(x: 0, y: -statusBarHeight,
                                                   width: self.bounds.width,
                                                   height: self.bounds.height + statusBarHeight))
            self.ch_overlay!.isUserInteractionEnabled = false
            self.ch_overlay!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        }
        self.isTranslucent = true
        self.insertSubview(self.ch_overlay!, at: 0)
        self.ch_overlay!.backgroundColor = backgroundColor;
    }
    
    
    /// 删除渐变颜色的背景
    func ch_removeBackgroundColor() {
        //删除渐变颜色的背景
        self.isTranslucent = false
        self.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.ch_overlay?.removeFromSuperview()
        self.ch_overlay = nil;
    }
    
    //重置导航栏颜色
    func ch_gradientBarColorForScrollViewOffset(offset: CGPoint) {
        
        let navBarChangePoint: CGFloat = 0  //滚动变化透明的界限
        let barHeight = self.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        let color = self.barTintColor!
        let offsetY = offset.y
        let alpha = min(1, 1 - ((navBarChangePoint + barHeight - offsetY) / barHeight ))
        if offsetY > navBarChangePoint {
            
            if alpha < 1 {
                
                self.ch_setBackgroundColor(color.withAlphaComponent(alpha))
                
            } else {
                //删除渐变颜色的背景
                self.ch_removeBackgroundColor()
            }
        } else {
            self.ch_setBackgroundColor(color.withAlphaComponent(0))
        }
    }
    
//    open override func awakeFromNib() {
//        super.awakeFromNib()
//    }
}


extension UIColor {
    
    /**
     把颜色转为图片对象
     
     - parameter color:
     
     - returns:
     */
    public func toImage() -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 0.5, height: 0.5);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(self.cgColor);
        context?.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    }
    
}
