//
//  LoginViewController.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var btnDone : UIBarButtonItem!
    var btnCancel : UIBarButtonItem!
    
    var tfUserName : UITextField!
    var tfPassword : UITextField!
    var tfServer : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 导航栏标题
        self.navigationItem.title = "用户登录"
        
        // 完成按钮
        self.btnDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("done"))
        self.navigationItem.rightBarButtonItem = self.btnDone
        
        // 取消按钮
        self.btnCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("cancel"))
        self.navigationItem.leftBarButtonItem = self.btnCancel
        
        self.tfUserName = UITextField(frame: CGRectZero)
        self.tfUserName.borderStyle = UITextBorderStyle.RoundedRect
        self.tfUserName.placeholder="请输入用户名"
        self.tfUserName.text="roger@rogeryee.com"
        self.tfUserName.adjustsFontSizeToFitWidth=true
        self.tfUserName.minimumFontSize=14
        self.tfUserName.contentVerticalAlignment = .Center
        self.tfUserName.contentHorizontalAlignment = .Left
        self.tfUserName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tfUserName)
        
        self.tfPassword = UITextField(frame: CGRectZero)
        self.tfPassword.borderStyle = UITextBorderStyle.RoundedRect
        self.tfPassword.placeholder="请输入密码"
        self.tfPassword.text="roger"
        self.tfPassword.adjustsFontSizeToFitWidth=true
        self.tfPassword.minimumFontSize=14
        self.tfPassword.contentVerticalAlignment = .Center
        self.tfPassword.contentHorizontalAlignment = .Left
        self.tfPassword.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tfPassword)
        
        self.tfServer = UITextField(frame: CGRectZero)
        self.tfServer.borderStyle = UITextBorderStyle.RoundedRect
        self.tfServer.placeholder="请输入服务器地址"
        self.tfServer.text="localhost"
        self.tfServer.adjustsFontSizeToFitWidth=true
        self.tfServer.minimumFontSize=14
        self.tfServer.contentVerticalAlignment = .Center
        self.tfServer.contentHorizontalAlignment = .Left
        self.tfServer.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tfServer)
        
        let views = ["username":self.tfUserName,"password":self.tfPassword,"server":self.tfServer]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[username(==200)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[password(==200)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[server(==200)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[username(==50)]-20-[password(==50)]-20-[server(==50)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tfUserName, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tfPassword, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tfServer, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tfPassword, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    func done() {
        NSUserDefaults.standardUserDefaults().setObject(self.tfUserName.text, forKey: "wechatID")
        NSUserDefaults.standardUserDefaults().setObject(self.tfPassword.text, forKey: "wechatPwd")
        NSUserDefaults.standardUserDefaults().setObject(self.tfServer.text, forKey: "wechatServer")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancel() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
