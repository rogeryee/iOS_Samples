//
//  UIPushButton.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class UIPushButton: UIButton {
    
    var rect:CGRect!
    
    var fillColor:UIColor!
    var isPlusType:Bool!
    
    init(fillColor:UIColor!, isPlusType:Bool!) {
        super.init(frame:CGRectZero)
        self.fillColor = fillColor
        self.isPlusType = isPlusType
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.rect = rect
        
        // draw the Circle
        drawCircle()
        
        // Draw the Plus sign
        drawPlusSign()
    }
    
    func drawCircle() {
        var path = UIBezierPath(ovalInRect: self.rect)
        self.fillColor.setFill()
        path.fill()
    }
    
    // Draw Plut sgin - "+"
    func drawPlusSign() {
        drawHorizontalStrokForPlusSign()
        
        if isPlusType! {
            drawVerticalStrokForPlusSign()
        }
    }
    
    // Draw horizontal stroke
    func drawHorizontalStrokForPlusSign() {
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
    
    // Draw Vertical stroke
    func drawVerticalStrokForPlusSign() {
        //set up the width and height variables
        //for the horizontal stroke
        let plusWidth: CGFloat = 3.0
        let plusHeight: CGFloat = min(bounds.height, bounds.width) * 0.6
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 - plusHeight/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 + plusHeight/2 + 0.5))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }

}
