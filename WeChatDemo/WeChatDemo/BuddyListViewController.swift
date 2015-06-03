//
//  ViewController.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class BuddyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PresenceDelegate {

    var appDelegate : AppDelegate!
    
    var tvBuddyList : UITableView!
    var btnLogin : UIBarButtonItem!
    var btnStatus : UIBarButtonItem!
    
    var buddyList = [WXMessage]()
    var samples = [
        "HelloWorld"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.appDelegate.presenceDelegate = self
    
        self.navigationController?.navigationBar.translucent = false
        
        // 导航栏标题
        self.navigationItem.title = "请登录..."
        
        // 登录按钮
        self.btnLogin = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("navigateToLogin"))
        self.navigationItem.rightBarButtonItem = self.btnLogin
        
        // 状态按钮
        self.btnStatus = UIBarButtonItem(title: "离线", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.btnStatus.tintColor = UIColor.grayColor()
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
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
    }
    
    override func viewWillAppear(animated: Bool) {
        checkAccountAndLogin()
    }
    
    // 检查账号是否存在，如存在则自动登录，否则跳转到登录界面
    func checkAccountAndLogin() {
        var defaults = NSUserDefaults.standardUserDefaults();
        var user = defaults.stringForKey(Constants.KEY_USER_ID)
        
        println("user = \(user)")
        
        if (user == nil) {
            navigateToLogin()
        }
        
        self.appDelegate.connectToServer()
    }
    
    func navigateToLogin() {
        var loginView = LoginViewController()
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
    func buddyOnline(presence: Presence) {
        println("buddyOnline \(presence.name)")
    }
    
    func buddyOffline(presence: Presence) {
        println("buddyOffine")
    }
    
    func selfOnline(presence: Presence) {
        println("selfOnline \(presence.name)")
        changeStatusButton(presence)
        changeNavigationTitle(presence)
    }
    
    func selfOffline(presence: Presence) {
        println("selfOffline")
        changeStatusButton(presence)
        changeNavigationTitle(presence)
    }
    
    func changeStatusButton(presence: Presence) {
        self.btnStatus.title = presence.isOnline ? "在线" : "离线"
        self.btnStatus.tintColor = presence.isOnline ? UIColor.greenColor() : UIColor.grayColor()
    }
    
    func changeNavigationTitle(presence: Presence) {
        self.navigationItem.title = presence.isOnline ? presence.name + "的好友列表" : "请登录..."
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

