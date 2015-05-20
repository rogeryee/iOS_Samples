//
//  SecondViewController.swift
//  NavigationCtrlSample
//
//  Created by Roger Yee on 5/19/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var hiddenOrShowBtn = UIButton()
        hiddenOrShowBtn.setTitle("Hidden|Show", forState: UIControlState.Normal)
        hiddenOrShowBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        hiddenOrShowBtn.backgroundColor = UIColor.whiteColor()
        hiddenOrShowBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        hiddenOrShowBtn.addTarget(self, action: Selector("hiddenOrShow:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(hiddenOrShowBtn)
        
        var pushBtn = UIButton()
        pushBtn.setTitle("Push", forState: UIControlState.Normal)
        pushBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        pushBtn.backgroundColor = UIColor.whiteColor()
        pushBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        pushBtn.addTarget(self, action: Selector("push:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(pushBtn)
        
        let views = ["hiddenOrShow":hiddenOrShowBtn, "push":pushBtn]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[hiddenOrShow(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[push(==140)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[hiddenOrShow(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[push(==40)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints([NSLayoutConstraint(item: hiddenOrShowBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: hiddenOrShowBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -30.0)])
        self.view.addConstraints([NSLayoutConstraint(item: pushBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: pushBtn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 30.0)])
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func hiddenOrShow(button:UIButton) {
        println("hiddenOrShow")
        var show:Bool = (self.navigationController?.toolbarHidden != nil && self.navigationController?.toolbarHidden == true) ? false : true
        self.navigationController?.setToolbarHidden(show, animated: true)
        self.navigationController?.setNavigationBarHidden(show, animated: true)
    }
    
    func push(button:UIButton) {
        var thirdViewController = ThirdViewController()
        self.navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}