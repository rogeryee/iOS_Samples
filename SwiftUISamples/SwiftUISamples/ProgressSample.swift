//
//  ProgressSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ProgressSample: SampleView {
    
    override func loadView() {
        
        var progressView=UIProgressView(progressViewStyle:UIProgressViewStyle.Bar)
        progressView.center=self.center
        progressView.progress=0.0
        progressView.setProgress(0.8,animated:true)
        progressView.progressTintColor=UIColor.greenColor()
        progressView.trackTintColor=UIColor.blueColor()
        self.addSubview(progressView);
    }
}