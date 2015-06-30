//
//  ViewController.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var countView:UICounterView!
    var pushPlusButton:UIPushButton!
    var pushMinusButton:UIPushButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.countView = UICounterView()
        self.countView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.countView)
        
        let plusColor = UIColor(red: 87/255, green: 218/255, blue: 213/255, alpha: 1)
        self.pushPlusButton = UIPushButton(fillColor: plusColor, isPlusType: true)
        self.pushPlusButton.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.pushPlusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.pushPlusButton)
        
        let minusColor = UIColor(red: 238/255, green: 77/255, blue: 77/255, alpha: 1)
        self.pushMinusButton = UIPushButton(fillColor: minusColor, isPlusType: false)
        self.pushMinusButton.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.pushMinusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.pushMinusButton)
        
        let views = ["count":self.countView,"plus":self.pushPlusButton, "minus":self.pushMinusButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[count(==230)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[count(==230)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.countView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.countView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -150.0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[plus(==100)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[plus(==100)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.pushPlusButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushPlusButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 50.0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[minus(==60)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[minus(==60)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushMinusButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushMinusButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 170.0))
    }

    func btnPushButton(button: UIPushButton) {
        if button.isPlusType! {
            self.countView.increaseCounter()
        } else {
            self.countView.decreaseCounter()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

