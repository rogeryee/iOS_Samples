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
    
    var titleLabel : UILabel!
    var avgLabel : UILabel!
    var avgCountLabel : UILabel!
    var maxLabel : UILabel!
    var zeroLabel : UILabel!
    
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
        
        // Draw labels
        self.titleLabel = UILabel(frame: CGRectMake(8, 8, 92, 21))
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.font = UIFont.systemFontOfSize(12)
        self.titleLabel.text = "Water Drunk"
        self.addSubview(self.titleLabel)
        
        self.avgLabel = UILabel(frame: CGRectMake(8, 32, 55, 24))
        self.avgLabel.textColor = UIColor.whiteColor()
        self.avgLabel.backgroundColor = UIColor.clearColor()
        self.avgLabel.textAlignment = NSTextAlignment.Left
        self.avgLabel.font = UIFont.systemFontOfSize(12)
        self.avgLabel.text = "Average : "
        self.addSubview(self.avgLabel)
        
        self.avgCountLabel = UILabel(frame: CGRectMake(66, 32, 42, 21))
        self.avgCountLabel.textColor = UIColor.whiteColor()
        self.avgCountLabel.backgroundColor = UIColor.clearColor()
        self.avgCountLabel.textAlignment = NSTextAlignment.Left
        self.avgCountLabel.font = UIFont.systemFontOfSize(12)
        self.avgCountLabel.text = "2"
        self.addSubview(self.avgCountLabel)
        
        self.maxLabel = UILabel(frame: CGRectMake(250, 49, 42, 21))
        self.maxLabel.textColor = UIColor.whiteColor()
        self.maxLabel.backgroundColor = UIColor.clearColor()
        self.maxLabel.textAlignment = NSTextAlignment.Right
        self.maxLabel.font = UIFont.systemFontOfSize(12)
        self.maxLabel.text = "8"
        self.addSubview(self.maxLabel)
        
        self.zeroLabel = UILabel(frame: CGRectMake(250, 190, 42, 21))
        self.zeroLabel.textColor = UIColor.whiteColor()
        self.zeroLabel.backgroundColor = UIColor.clearColor()
        self.zeroLabel.textAlignment = NSTextAlignment.Right
        self.zeroLabel.font = UIFont.systemFontOfSize(12)
        self.zeroLabel.text = "0"
        self.addSubview(self.zeroLabel)
        
        // Set Date Labels
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: 200)
            point.x += 2
            point.y += 5
            
            var label = UILabel(frame: CGRectMake(point.x - 10, point.y, 20, 21))
            label.textColor = UIColor.whiteColor()
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Right
            label.font = UIFont.systemFontOfSize(12)
            
            let dateFormatter = NSDateFormatter()
            let calendar = NSCalendar.currentCalendar()
            let componentOptions:NSCalendarUnit = NSCalendarUnit.CalendarUnitWeekday
            let interval:Double = 60 * 60 * 24 * Double((i - 6))
            let component = calendar.components(componentOptions, fromDate:NSDate(timeIntervalSinceNow:interval))
            
//            println("i = \(i), componnet.weekday = \(component.weekday)")
            label.text = component.weekday == 7 ? "\(days[0])" : "\(days[component.weekday])"
            self.addSubview(label)
        }
    }
    
    func reDrawGraph(currentCounter:Int) {
        self.graphPoints[self.graphPoints.count - 1] = currentCounter
        
        self.setNeedsDisplay()
        
        self.maxLabel.text = "\(maxElement(self.graphPoints))"
        
        let average = self.graphPoints.reduce(0, combine: +) / self.graphPoints.count
        self.avgCountLabel.text = "\(average)"
    }
}
