//
//  ThirdViewController.swift
//  NavigationCtrlSample
//
//  Created by Roger Yee on 5/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//


import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.redColor()
        
        var pushBtn = UIButton()
        pushBtn.setTitle("Push", forState: UIControlState.Normal)
        pushBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        pushBtn.backgroundColor = UIColor.whiteColor()
        pushBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        pushBtn.addTarget(self, action: Selector("push:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(pushBtn)
        
        var popBtn = UIButton()
        popBtn.setTitle("Pop", forState: UIControlState.Normal)
        popBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        popBtn.backgroundColor = UIColor.whiteColor()
        popBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        popBtn.addTarget(self, action: Selector("pop:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(popBtn)
        
        var rootBtn = UIButton()
        rootBtn.setTitle("Root", forState: UIControlState.Normal)
        rootBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rootBtn.backgroundColor = UIColor.whiteColor()
        rootBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        rootBtn.addTarget(self, action: Selector("root:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(rootBtn)
        
        var indexBtn = UIButton()
        indexBtn.setTitle("Index", forState: UIControlState.Normal)
        indexBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        indexBtn.backgroundColor = UIColor.whiteColor()
        indexBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        indexBtn.addTarget(self, action: Selector("index:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(indexBtn)
        
        let views = ["push":pushBtn,"pop":popBtn,"root":rootBtn,"index":indexBtn]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[push(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[push(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[pop(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[pop(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[root(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[root(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[index(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[index(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints([NSLayoutConstraint(item: pushBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: pushBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -90.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: popBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: popBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -30.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: rootBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: rootBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 30.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: indexBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: indexBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 90.0)])
    }
    
    // Push一个新的ThirdViewController
    func push(button:UIButton) {
        var thirdViewController = ThirdViewController()
        self.navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    // Pop到上一层UIViewController
    func pop(button:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 直接Pop到根UIViewController
    func root(button:UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // 返回到指定的（本例中为倒数第二个）UIViewController
    func index(button:UIButton) {
        var viewController: UIViewController = self.navigationController?.viewControllers[1] as! UIViewController;
        self.navigationController?.popToViewController(viewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}