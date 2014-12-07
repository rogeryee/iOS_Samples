//
//  ActivityIndicatorAndAlertSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/7/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class ActivityIndicatorAndAlertSample: SampleView, UIAlertViewDelegate {

    var startBtn : UIButton!
    var stopBtn : UIButton!
    var activityInd : UIActivityIndicatorView!
    
    override func loadView() {
        
        self.startBtn = UIButton(frame: CGRectMake(80,100,50,60))
        self.startBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.startBtn.setTitle("开始", forState: .Normal)
        self.startBtn.addTarget(self, action: "startLoading:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.activityInd = UIActivityIndicatorView(frame: CGRectMake(150, 90, 80, 80))
        self.activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.activityInd.color = UIColor.redColor()
        
        self.stopBtn = UIButton(frame: CGRectMake(250,100,50,60))
        self.stopBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.stopBtn.setTitle("停止", forState: .Normal)
        self.stopBtn.addTarget(self, action: "stopLoading:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.startBtn)
        self.addSubview(self.activityInd)
        self.addSubview(self.stopBtn)
    }
    
    func startLoading(sender: AnyObject) {
        self.activityInd.startAnimating()
    }
    
    func stopLoading(sender: AnyObject) {
        
        let stopConfirmDialog = UIAlertView(
            title: "警告",
            message: "您确定要停止吗？",
            delegate: self,
            cancelButtonTitle: "否",
            otherButtonTitles: "是"
        )
        stopConfirmDialog.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.activityInd.stopAnimating()
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

