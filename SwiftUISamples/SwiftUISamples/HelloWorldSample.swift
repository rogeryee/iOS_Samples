//
//  HelloWorldSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/6/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class HelloWorldSample: SampleView {

    override func loadView() {
        
        let label = UILabel(frame:self.bounds)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(20)
        label.text = "Hello Roger, welcome to Swift world."
        
        self.addSubview(label)
    }

}
