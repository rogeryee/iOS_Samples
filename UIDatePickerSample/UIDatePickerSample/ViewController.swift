//
//  ViewController.swift
//  UIDatePickerSample
//
//  Created by Roger Yee on 4/23/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var showDateTimeButton: UIButton!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dateTimeChanged(sender: UIDatePicker) {
        
        let df = NSDateFormatter()
        df.dateFormat = "yyyy年M月d日 HH:mm:ss"
        
        let dateStr = df.stringFromDate(sender.date)
        dateTimeLabel.text = dateStr
    }

    @IBAction func showDateTime(sender: UIButton) {
        println("showDateTime")
        let alertView = UIAlertView()
        alertView.title = "当前时间"
        alertView.message = "您选择的时间是：\(dateTimeLabel.text!)"
        alertView.addButtonWithTitle("确定")
        alertView.show()
    }
}

