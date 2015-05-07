//
//  StepperSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class StepperSample: SampleView {
    
    var stepper:UIStepper!
    var label:UILabel!
    
    override func loadView() {
        
        stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 1
        stepper.stepValue = 1
        stepper.continuous = true
        stepper.wraps = true
        stepper.addTarget(self, action: Selector("valueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        stepper.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(stepper)
        
        label = UILabel()
        label.text = "当前值为：\(stepper.value)"
        label.textAlignment = NSTextAlignment.Center
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(label)
        
        // Add Constrains
        let views = ["label": label,"stepper":stepper]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[stepper(==50)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[stepper(==30)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[label(==200)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label(==20)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=100)-[stepper]-20-[label]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
        self.addConstraints([NSLayoutConstraint(item: stepper, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.addConstraints([NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
    }
    
    func valueChanged() {
        println(stepper.value)
        label.text = "当前值为：\(stepper.value)"
    }
    
}