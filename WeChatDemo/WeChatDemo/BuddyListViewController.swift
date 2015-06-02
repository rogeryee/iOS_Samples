//
//  ViewController.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class BuddyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tvBuddyList : UITableView!
    var btnLogin : UIBarButtonItem!
    var btnStatus : UIBarButtonItem!
    
    var buddyList = [WXMessage]()
    var samples = [
        "HelloWorld",
        "Button",
        "Text Field",
        "Switch",
        "Segmented Control",
        "ImageView",
        "Progress",
        "Slider",
        "ActionSheetView",
        "ActivityIndicator + AlertView",
        "PickView",
        "Stepper",
        "Scroll View",
        "Date Picker",
        "Web View",
        "Web Browser",
        "NSLayoutConstraint",
        "TableView(WeChat)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.translucent = false;
        // 导航栏标题
        self.navigationItem.title = "好友列表"
        
        // 登录按钮
        self.btnLogin = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("login"))
        self.navigationItem.rightBarButtonItem = self.btnLogin
        
        // 状态按钮
        self.btnStatus = UIBarButtonItem(title: "状态", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("status"))
        self.navigationItem.leftBarButtonItem = self.btnStatus
        
        // 好友表格
        self.tvBuddyList = UITableView(frame:CGRectZero)
        self.tvBuddyList.delegate = self
        self.tvBuddyList.dataSource = self
        self.tvBuddyList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        self.tvBuddyList.scrollEnabled = true;
        self.tvBuddyList.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tvBuddyList)
        
        // Constraints
        let views = ["table":self.tvBuddyList]
//        let metrics = ["headHeight":((self.navigationController?.navigationBar.frame.height)!+20.0)]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
    }
    
    func login() {
        var loginView = LoginViewController()
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
    func status() {
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.samples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = self.samples[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var detailedViewController = ChatViewController()
        self.navigationController!.pushViewController(detailedViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

