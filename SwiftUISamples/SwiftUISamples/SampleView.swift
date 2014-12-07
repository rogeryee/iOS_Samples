//
//  SampleProtocol.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/6/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class SampleView : UIView {
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        loadView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    // This method should be overrided by sub-classes.
    func loadView() {
    
    }
}
