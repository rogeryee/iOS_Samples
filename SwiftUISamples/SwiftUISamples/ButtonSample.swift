//
//  ButtonSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ButtonSample: SampleView {
    
    override func loadView() {
        
        //创建一个ContactAdd类型的按钮
        //var button:UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton;
        var button = UIButton(frame:CGRectMake(10, 150, 100, 30))
        //设置按钮位置和大小
        button.frame=CGRectMake(10, 150, 100, 30);
        //设置按钮文字
        button.setTitle("按钮", forState:UIControlState.Normal)
        button.setTitle("普通状态", forState:UIControlState.Normal)
        button.setTitle("触摸状态", forState:UIControlState.Highlighted)
        button.setTitle("禁用状态", forState:UIControlState.Disabled)
        button.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button.setTitleColor(UIColor.greenColor(),forState: .Highlighted)
        button.setTitleColor(UIColor.grayColor(),forState: .Disabled)
        
        button.setTitleShadowColor(UIColor.greenColor(),forState:.Normal)
        button.setTitleShadowColor(UIColor.yellowColor(),forState:.Highlighted)
        button.setTitleShadowColor(UIColor.grayColor(),forState:.Disabled)
        button.backgroundColor=UIColor.whiteColor()
        
        button.setImage(UIImage(named:"icon"),forState:.Normal)
        button.adjustsImageWhenHighlighted=true
        button.adjustsImageWhenDisabled=true
        //button.setBackgroundImage(UIImage(named:"background"),forState:.Normal)
        button.addTarget(self,action:Selector("tapped:"),forControlEvents:UIControlEvents.TouchUpInside)
        
        self.addSubview(button)
    }
    
    func tapped(button:UIButton){
        println(button.titleForState(.Normal))
    }
    
}
