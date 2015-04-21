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
        
        stepper = UIStepper(frame: CGRectMake(10, 200, 20, 20))
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 1
        stepper.stepValue = 1
        stepper.continuous = true
        stepper.wraps = true
        stepper.addTarget(self, action: Selector("valueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(stepper)
        
        label = UILabel(frame: CGRectMake(10, 250, 20, 20))
        label.text = "当前值为：\(stepper.value)"
        self.addSubview(label)
    }
    
    func valueChanged() {
        println(stepper.value)
        label.text = "当前值为：\(stepper.value)"
    }
    
}