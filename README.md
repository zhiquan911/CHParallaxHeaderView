# CHParallaxHeaderView

[![CI Status](http://img.shields.io/travis/麦志泉/CHParallaxHeaderView.svg?style=flat)](https://travis-ci.org/麦志泉/CHParallaxHeaderView)
[![Version](https://img.shields.io/cocoapods/v/CHParallaxHeaderView.svg?style=flat)](http://cocoapods.org/pods/CHParallaxHeaderView)
[![License](https://img.shields.io/cocoapods/l/CHParallaxHeaderView.svg?style=flat)](http://cocoapods.org/pods/CHParallaxHeaderView)
[![Platform](https://img.shields.io/cocoapods/p/CHParallaxHeaderView.svg?style=flat)](http://cocoapods.org/pods/CHParallaxHeaderView)

![demo.gif](https://github.com/zhiquan911/CHParallaxHeaderView/blob/master/demo.gif)

## Features

- 使用Swift扩展特性编写，调用简单
- UIView扩展支持视差缩放效果
- UINavigationBar扩展支持视差渐变效果

## Requirements

- iOS 8+
- Xcode 8+
- Swift 3.0+
- iPhone/iPad

## Installation

CHParallaxHeaderView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CHParallaxHeaderView"
```

## Example

```swift
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageViewHeader: UIView!

    //在view出现时添加特性
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UIColor(white: 1, alpha: 1)
        //添加渐变效果并跟踪着哪个View
        self.navigationController?.navigationBar.ch_addGradient(by: self.tableView,
                                                                barColor: color)
        
        //添加缩放视差效果并跟踪着哪个View
        self.imageViewHeader.ch_addParallax(by: self.tableView)
    }

    //在view消失时移除特性
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //当控制器是消失时，把绑定的跟踪移除
        self.navigationController?.navigationBar.ch_removeGradient()
        self.imageViewHeader.ch_removeParallax()
    }

```

## Author

Chance, zhiquan911@qq.com

## Donations

为了让开发者更积极分享技术，开源程序代码，我们发起数字货币捐助计划，捐款只接收以下货币。

- **BTC Address**:  3G4NdQQyCJK1RS5URb4h5KogWEyR4Mk16A

## License

CHParallaxHeaderView is available under the MIT license. See the LICENSE file for more info.
