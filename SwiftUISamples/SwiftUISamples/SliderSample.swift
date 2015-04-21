//
//  SliderSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//


import UIKit

class SliderSample: SampleView {
    
    override func loadView() {
        
        var slider=UISlider(frame:CGRectMake(0,0,300,50))
        slider.center=self.center
        slider.minimumValue=0
        slider.maximumValue=1
        slider.value=0.5
        slider.setValue(0.8,animated:true)
        slider.continuous=true
        slider.minimumTrackTintColor=UIColor.redColor()
        slider.maximumTrackTintColor=UIColor.greenColor()
        
        slider.minimumValueImage=UIImage(named:"volumeOff")
        slider.maximumValueImage=UIImage(named:"volumeOn")
        
        //slider.setMaximumTrackImage(UIImage(named:"slider_max"),forState:UIControlState.Normal)
        //slider.setMinimumTrackImage(UIImage(named:"slider_min"),forState:UIControlState.Normal)
        
        //设置滑块的图片
        slider.setThumbImage(UIImage(named:"slider"),forState:UIControlState.Normal)
        
        slider.addTarget(self,action:"sliderDidchange:", forControlEvents:UIControlEvents.ValueChanged)
        
        self.addSubview(slider)
    }
    
    func sliderDidchange(slider:UISlider){
        println(slider.value)
    }
}