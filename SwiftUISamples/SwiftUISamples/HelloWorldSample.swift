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
        
        // Label widget
        let label = UILabel(frame:self.bounds)
        label.textColor=UIColor.whiteColor()
        label.backgroundColor=UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        //label.font = UIFont.systemFontOfSize(20)
        label.font = UIFont(name:"Zapfino", size:20)
        label.text = "Hello Roger! Welcome to Swift World!"
        label.shadowColor=UIColor.grayColor()
        label.shadowOffset=CGSizeMake(-5,5)
        
        // 文字省略方式
        label.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        //label.adjustsFontSizeToFitWidth = true
        
        self.addSubview(label)
    }

}
