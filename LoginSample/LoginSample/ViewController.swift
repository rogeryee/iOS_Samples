//
//  ViewController.swift
//  LoginSample
//
//  Created by Roger Yee on 11/28/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let db = DummyDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchToPasswordField(sender: AnyObject) {
        passwordField.becomeFirstResponder()
    }

    @IBAction func login(sender: AnyObject) {
        var username = usernameField.text
        //usernameField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var password = passwordField.text
        //passwordField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        var msg:String = ""
        if username == nil || username.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            msg = "Please enter your name!"
        }
        else if password == nil || password.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            msg = "Please enter your password!"
        }
        else {
            
            var pwdFromDB = db.getUser(username)
            if password == pwdFromDB {
                msg = "Login Successfully!"
            }
            else if pwdFromDB == nil {
                msg = "User not found!"
            }
            else {
                msg = "Invalid password!"
            }
        }
        
        msgLabel.text = msg
    }
}

