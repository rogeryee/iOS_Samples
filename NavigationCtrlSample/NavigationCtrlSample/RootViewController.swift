//
//  ViewController.swift
//  NavigationCtrlSample
//
//  Created by Roger Yee on 5/19/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.purpleColor()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

