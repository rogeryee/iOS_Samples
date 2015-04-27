//
//  DatePickerSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/27/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class DatePickerSample: SampleView {
    
    var dateTimeLabel: UILabel!
    var showDateTimeButton: UIButton!
    var dateTimePicker: UIDatePicker!
    
    override func loadView() {
        
        dateTimePicker = UIDatePicker(frame: CGRectMake(10, 100, 100, 180))
        dateTimePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        dateTimePicker.addTarget(self, action: Selector("dateTimeChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(dateTimePicker)
        
        dateTimeLabel = UILabel(frame:CGRectMake(50, 350, 200, 30))
        dateTimeLabel.textColor=UIColor.whiteColor()
        dateTimeLabel.backgroundColor=UIColor.blackColor()
        dateTimeLabel.textAlignment = NSTextAlignment.Center
        dateTimeLabel.font = UIFont(name:"Zapfino", size:10)
        dateTimeLabel.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        self.addSubview(dateTimeLabel)
        
        showDateTimeButton = UIButton(frame:CGRectMake(50, 400, 100, 30))
        showDateTimeButton.setTitle("查看时间", forState: UIControlState.Normal)
        showDateTimeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        showDateTimeButton.addTarget(self,action:Selector("showDateTime:"),forControlEvents:UIControlEvents.TouchUpInside)
        self.addSubview(showDateTimeButton)
    }
    
    
    func dateTimeChanged(sender: UIDatePicker) {
        
        let df = NSDateFormatter()
        df.dateFormat = "yyyy年M月d日 HH:mm:ss"
        
        let dateStr = df.stringFromDate(sender.date)
        dateTimeLabel.text = dateStr
    }
    
    func showDateTime(sender: UIButton) {
        println("showDateTime")
        let alertView = UIAlertView()
        alertView.title = "当前时间"
        alertView.message = "您选择的时间是：\(dateTimeLabel.text!)"
        alertView.addButtonWithTitle("确定")
        alertView.show()
    }
}