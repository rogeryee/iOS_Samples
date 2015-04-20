//
//  SwitchSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class SwitchSample: SampleView {
    
    var uiSwitch:UISwitch!
    override func loadView() {
        
        // Label widget
        uiSwitch = UISwitch()
        uiSwitch.center = CGPointMake(100,200)
        uiSwitch.on = true
        
        uiSwitch.addTarget(self, action: Selector("switchDidChange"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.addSubview(uiSwitch)
    }
    
    func switchDidChange() {
        println("switch is \(self.uiSwitch.on)")
    }
    
}