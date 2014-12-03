//
//  ViewController.swift
//  HelloWorld
//
//  Created by Roger Yee on 11/27/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Sample - "Say Hey"
    @IBOutlet weak var heyLabel: UILabel!
    
    // Sample - 超级RP计算器
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var rpResultField: UILabel!
    @IBAction func rpCalculate(sender: AnyObject) {
        rpResultField.text = nameTextField.text + ", 聪明好学，多彩多艺"
    }
    @IBAction func closeKeyBoard(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    // Sample - 加法计算器
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var calcResultField: UILabel!
    @IBAction func mathCalculate(sender: AnyObject) {
        var result:Int = number1.text.toInt()! + number2.text.toInt()!
        calcResultField.text = String(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sayHey(sender: AnyObject) {
        heyLabel.text = "Hey"
    }
}

