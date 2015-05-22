//
//  ViewController.swift
//  NavigationCtrlSample
//
//  Created by Roger Yee on 5/19/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.purpleColor()
        
        self.navigationController?.delegate = self
        
        // Custom NavigationBar
        var item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: Selector("study"))
        
        // 1. 一个导航控制器(UINavigationController)控制着若干个视图控制器(UIViewController)
        // 2. 一个导航控制器包含一个NavigationBar和一个toolBar
        // 3. NavigationBar中的元素（按钮等）是一个UINavigationItem
        // 4. 通过设置UINavigationItem的属性，显示Item
        // 5. UINavigationItem不是由NavigationBar控制的，更不是由UINavigationController来控制的，而是由当前视图控制器控制的
        // 错误的写法 self.navigationController?.navigationItem.leftBarButtonItem = item
        self.navigationItem.leftBarButtonItem = item
        
        var titleView = UIView(frame: CGRectMake(0, 0, 100, 30))
        titleView.backgroundColor = UIColor.blueColor()
        self.navigationItem.titleView = titleView
        
        var button = UIButton()
        button.setTitle("Push", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(self, action: Selector("push:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        let views = ["button":button]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[button(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints([NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)])
    }
    
    func push(button:UIButton) {
        println("push")
        var secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func study() {
        var alert = UIAlertView(title: "Study", message: "Congratulation", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        println("navigationController")
    }
}

