//
//  NSLayoutConstraintSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 5/6/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class NSLayoutConstraintSample: SampleView {
    
    var label1:UILabel!
    var label2:UILabel!
    var label3:UILabel!
    
    override func loadView() {
        println("load NSLayoutConstraintSample")
        firstSample()
//        secondSample()
    }
    
    func firstSample() {
        label1 = UILabel(frame: CGRectMake(0, 160, 40,30))
        label1.textColor=UIColor.blackColor()
        label1.backgroundColor=UIColor.greenColor()
        label1.textAlignment = NSTextAlignment.Center
        label1.font = UIFont(name:"Zapfino", size:12)
        label1.text = "Label 1"
        label1.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(label1)
        
        label2 = UILabel(frame: CGRectMake(0, 160, 40,30))
        label2.textColor=UIColor.blackColor()
        label2.backgroundColor=UIColor.yellowColor()
        label2.textAlignment = NSTextAlignment.Center
        label2.font = UIFont(name:"Zapfino", size:12)
        label2.text = "Label 2"
        label2.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(label2)
        
        label3 = UILabel(frame: CGRectMake(0, 160, 40,30))
        label3.textColor=UIColor.blackColor()
        label3.backgroundColor=UIColor.blueColor()
        label3.textAlignment = NSTextAlignment.Center
        label3.font = UIFont(name:"Zapfino", size:12)
        label3.text = "Label 3"
        label3.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(label3)
        
        addConstraints()
    }
    
    func addConstraints() {
        // Add Constraints
        let views = ["superview":self,"label1": label1,"label2":label2,"label3":label3]
        
        // Add Constraints to label1
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[label1]-10-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[label1(==70)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        // Add Constraints to label2
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[label2]-10-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label1]-30-[label2(==70)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        // Add Constraints to label3
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[label3(==100)]", options: nil, metrics: nil, views: views))
        
        // label3.center.x = superview.center.x * 1.0 + 0.0
        self.addConstraints([NSLayoutConstraint(item: label3, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        // label3.center.y = superview.center.y * 1.0 + 0.0
        self.addConstraints([NSLayoutConstraint(item: label3, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)])
    }
    
    func secondSample() {
        
        var blueView = UIView();
        blueView.backgroundColor = UIColor.blueColor()
        
        var greenView = UIView();
        greenView.backgroundColor = UIColor.greenColor()
        
        self.addSubview(blueView);
        self.addSubview(greenView);
        
        greenView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blueView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let views = ["green": greenView,"blue":blueView]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[blue]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[blue]-(==30)-[green(==blue)]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[green(==blue)]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
    }
}