//
//  UIGraphicView.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/30/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class UIGraphicView: UIView {
    
    var chart:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
        
        self.chart = UIView()
//        self.chart.layer.borderWidth = 1
//        self.chart.layer.borderColor = UIColor.blackColor().CGColor
        self.chart.backgroundColor = UIColor.whiteColor()
        self.chart.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.chart)
        
//        self.opaque = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
//        var context = UIGraphicsGetCurrentContext();
//        CGContextClearRect(context, rect)
        
        // Set label constraints
        let views = ["chart":self.chart]
        self.addConstraint(NSLayoutConstraint(item: self.chart, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.chart, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[chart(==300)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[chart(==250)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))

    }

}
