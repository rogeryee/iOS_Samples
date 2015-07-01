//
//  UIGraphicView.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/30/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class UIGraphicView: UIView {
    
    var startColor : UIColor = UIColor(red: 250/255, green: 233/255, blue: 222/255, alpha: 1)
    var endColor : UIColor = UIColor(red: 252/255, green: 79/255, blue: 8/255, alpha: 1)
    
    var graphPoints:[Int] = [4, 2, 6, 4, 5, 8, 3]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, rect)

        let width = rect.width
        let height = rect.height
        
        // Set Clipping Area (Should be before setting gradient)
        var path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()

        // Set Gradient
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        
        var startPoint = CGPoint.zeroPoint
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
            gradient,
            startPoint,
            endPoint,
            0)
        
        // Calculate x point
        let margin:CGFloat = 20.0
        var columnXPoint = { (column:Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // calculate y point
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = maxElement(graphPoints)
        var columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            y = graphHeight - y + topBorder
            return y
        }
        
        // Draw the Line Graph
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        // set up the points line
        var graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
            y:columnYPoint(graphPoints[0])))
        
        // add points for each item in the graphPoints array at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        graphPath.lineWidth = 2
        graphPath.stroke()
        
        // Create the clipfor the graph gradient
        CGContextSaveGState(context)
        var clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
        clippingPath.closePath()
        clippingPath.addClip()
        
        let hightestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y:hightestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
        
        // Draw the circles on top of graph stroke
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //Draw horizontal graph lines on the top of everything
        var linePath = UIBezierPath()
        
        //top line
        linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin,
            y:topBorder))
        
        //center line
        linePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.moveToPoint(CGPoint(x:margin, y:height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin, y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }

}
