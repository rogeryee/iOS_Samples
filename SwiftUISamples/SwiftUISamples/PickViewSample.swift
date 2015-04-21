//
//  PickViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class PickViewSample: SampleView,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView:UIPickerView!
    
    override func loadView() {
        
        pickerView=UIPickerView()
        pickerView.dataSource=self //将dataSource设置成自己
        pickerView.delegate=self //将delegate设置成自己
        
        //设置选择框的默认值
        pickerView.selectRow(1,inComponent:0,animated:true)
        pickerView.selectRow(3,inComponent:1,animated:true)
        pickerView.selectRow(4,inComponent:2,animated:true)
        self.addSubview(pickerView)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        var button=UIButton(frame:CGRectMake(0,20,100,30))
        button.center=self.center
        button.backgroundColor=UIColor.blueColor()
        button.setTitle("获取信息",forState:.Normal)
        button.addTarget(self, action:"getPickerViewValue", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int{
        return 3
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        return 9
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(pickerView: UIPickerView!,titleForRow row: Int,forComponent component: Int) -> String!{
        return String(component) + "-" + String(row)
    }
    
    //触摸按钮时，获得被选中的索引
    func getPickerViewValue(){
        var alertView=UIAlertView();
        alertView.title="被选中的索引为"
        alertView.message=String(pickerView.selectedRowInComponent(0))+"-"+String (pickerView.selectedRowInComponent(1))+"-"+String(pickerView.selectedRowInComponent(2))
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    
}