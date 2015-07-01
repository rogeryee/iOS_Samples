//
//  CounterView.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

class UICounterView: UIView {

    var counter: Int = 5 {
        didSet {
            if counter <= NoOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    var outlineColor: UIColor = UIColor(red: 34/255, green: 110/255, blue: 100/255, alpha: 1)
    var counterColor: UIColor = UIColor(red: 87/255, green: 218/255, blue: 213/255, alpha: 1)
    
    var glassLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
        
//        self.backgroundColor = UIColor.clearColor()
        
        self.glassLabel = UILabel()
        self.glassLabel.text = String(counter)
        self.glassLabel.textAlignment = .Center
        self.glassLabel.font = UIFont.systemFontOfSize(36)
        self.glassLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.glassLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, rect)
        
        
        drawArc()
    }
    
    func drawArc() {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        // Draw Arc
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        path.lineWidth = arcWidth
        self.counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        var outlinePath = UIBezierPath(arcCenter: center,
            radius: radius/2 - 2.5,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArcWithCenter(center,
            radius: bounds.width/2 - arcWidth + 2.5,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        //4 - close the path
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        // Set label constraints
        let views = ["label":self.glassLabel]
        self.addConstraint(NSLayoutConstraint(item: self.glassLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.glassLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        
        let width = bounds.width/2 - 76/2
        let height = width
        
        let metrics = ["width":width, "height":height]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[label(==width)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label(==height)]", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
    }
    
    func increaseCounter() {
        if self.counter >= NoOfGlasses {
            return
        }
        self.counter++
        self.glassLabel.text = String(self.counter)
    }
    
    func decreaseCounter() {
        if self.counter < 1 {
            return
        }
        self.counter--
        self.glassLabel.text = String(self.counter)
    }
}

