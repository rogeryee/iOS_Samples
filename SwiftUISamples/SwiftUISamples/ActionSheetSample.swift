//
//  ActionSheetSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/7/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class ActionSheetSample: SampleView, UIActionSheetDelegate {
    
    var actionSheet : UIActionSheet!
    var shareButton : UIButton!
    var resultLabel : UILabel!
    
    override func loadView() {
        
        self.actionSheet = UIActionSheet(
            title: nil,
            delegate: self,
            cancelButtonTitle: "取消",
            destructiveButtonTitle: "分享到新浪微博",
            otherButtonTitles:"分享到QQ空间"
        )
        
        self.shareButton = UIButton(frame: CGRectMake(80,100,200,60))
        self.shareButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.shareButton.setTitle("分享到...", forState: .Normal)
        self.shareButton.addTarget(self, action: "shareTo:", forControlEvents: UIControlEvents.TouchUpInside)

        self.resultLabel = UILabel(frame:CGRectMake(80,200,200,60))
        self.resultLabel.backgroundColor = UIColor.clearColor()
        self.resultLabel.textAlignment = NSTextAlignment.Center
        self.resultLabel.font = UIFont.systemFontOfSize(20)
        self.resultLabel.text = ""
        
        self.addSubview(self.shareButton!)
        self.addSubview(self.resultLabel!)
    }
    
    func shareTo(sender:AnyObject) {
        println("aaa")
        self.actionSheet.showInView(self)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        self.resultLabel.text = self.actionSheet.buttonTitleAtIndex(buttonIndex)
    }
   
}
