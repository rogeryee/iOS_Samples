//
//  TabBarViewController.swift
//  TabBar_NavigationSample
//
//  Created by Roger Yee on 5/22/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TabBarViewController : UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // 隐藏系统自带的TabBar
        self.tabBar.hidden = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        // 加载自定义的TabBar
        loadCustomTabBar()
    }
    
    func loadCustomTabBar() {
        
        var bgView = UIView()
        bgView.backgroundColor = UIColor.grayColor()
        bgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(bgView)
        
        var msgBtn = UIButton()
        msgBtn.tag = 0
        msgBtn.setBackgroundImage(UIImage(named: "bubble"), forState: UIControlState.Normal)
        msgBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        msgBtn.addTarget(self, action: Selector("msg:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(msgBtn)
        
        var downloadBtn = UIButton()
        downloadBtn.tag = 1
        downloadBtn.setBackgroundImage(UIImage(named: "cloud-download"), forState: UIControlState.Normal)
        downloadBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        downloadBtn.addTarget(self, action: Selector("download:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(downloadBtn)
        
        let views = ["bg":bgView,"msg":msgBtn,"download":downloadBtn]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bg]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bg(==70)]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[msg]-20-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[download]-20-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: msgBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 0.5, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: downloadBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.5, constant: 0.0))
    }
    
    func msg(button:UIButton) {
        self.selectedIndex = button.tag
    }
    
    func download(button:UIButton) {
        self.selectedIndex = button.tag
    }
}