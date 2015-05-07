//
//  SegmentedControlSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class SegmentedControlSample: SampleView {
    
    override func loadView() {
        
        var items=["选项一","选项二"] as [AnyObject]
        var segmented=UISegmentedControl(items:items)
        segmented.center=self.center
        segmented.selectedSegmentIndex=1
        segmented.tintColor=UIColor.redColor()
        segmented.setTitle("swfit",forSegmentAtIndex:1)
        segmented.insertSegmentWithTitle("新增选项",atIndex:1,animated:true);
        segmented.addTarget(self, action: "segmentDidchange:", forControlEvents: UIControlEvents.ValueChanged)
        segmented.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addSubview(segmented)
        
        self.addConstraints([NSLayoutConstraint(item: segmented, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.addConstraints([NSLayoutConstraint(item: segmented, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)])
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        println(segmented.selectedSegmentIndex)
        //获得选择的文字
        println(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }}
