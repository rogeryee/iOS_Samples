//
//  TextSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TextSample: SampleView,UITextFieldDelegate {
    
    var textField:UITextField!
    var textview:UITextView!
    
    override func loadView() {
        
        textField = UITextField(frame: CGRectMake(10,160,200,30))
        
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder="请输入用户名"
        textField.text="luofei614"
        textField.adjustsFontSizeToFitWidth=true
        textField.minimumFontSize=14
        textField.contentVerticalAlignment = .Center
        
        // Return/Search/Join/Next/Send
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode=UITextFieldViewMode.Always
        textField.background=UIImage(named:"background");
        textField.delegate=self
        self.addSubview(textField)
        
        // Multiple line
        textview=UITextView(frame:CGRectMake(10,200,200,100))
        textview.layer.borderWidth=1
        textview.layer.borderColor=UIColor.grayColor().CGColor
        textview.text="第一行\n第二行\n第三行\n第四行\n第五行"
        textview.editable=false
        textview.dataDetectorTypes = UIDataDetectorTypes.All
        textview.scrollRangeToVisible(NSMakeRange(0, 50))
        self.addSubview(textview)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        println(textField.text)
        textview.text = textField.text
        return true;
    }
    
}
