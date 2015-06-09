//
//  ViewController.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class BuddyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PresenceDelegate, MessageDelegate {

    var appDelegate : AppDelegate!
    
    var tvBuddyList : UITableView!
    var btnLogin : UIBarButtonItem!
    var btnStatus : UIBarButtonItem!

    var buddies = [Buddy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.appDelegate.presenceDelegate = self
        self.appDelegate.messageDelegate = self
    
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
        self.tvBuddyList.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tvBuddyList.delegate = self
        self.tvBuddyList.dataSource = self
        self.tvBuddyList.registerClass(BuddyTableViewCell.self, forCellReuseIdentifier: BuddyTableViewCell.CELL_IDENTITY)
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
        
        if (user == nil) {
            navigateToLogin()
        }
        
        // 如果当前登录用户未改变，则无需重复登录
        var stream = self.appDelegate.xmppStream
        if (stream != nil && stream?.isConnected() != nil) {
            var loginUser = (stream?.myJID.user)! + "@" + (stream?.myJID.domain)!
            if loginUser == user {
                return
            }
        }

        self.appDelegate.connectToServer()
    }
    
    func navigateToLogin() {
        var loginView = LoginViewController()
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
    func buddyOnline(presence: Presence) {
        println("buddyOnline \(presence.name)")
        
        var name = presence.name
        var buddy = findBuddyByName(name)
        if buddy == nil {
            buddy = Buddy(name:name)
            buddies.append(buddy!)
        }
        
        buddy!.isOnline = true
        self.tvBuddyList.reloadData()
    }
    
    func buddyOffline(presence: Presence) {
        println("buddyOffine")
        
        var name = presence.name
        var buddy = findBuddyByName(name)
        if buddy == nil {
            buddy = Buddy(name:name)
            buddies.append(buddy!)
        }
        
        buddy!.isOnline = false
        self.tvBuddyList.reloadData()
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
    
    func newMessage(message: Message) {
        return
    }
    
    func receiveMessage(message: Message) {
        var name = message.from.name
        var buddy = findBuddyByName(name)
        if buddy == nil {
            return
        }
        
        if !message.isComposing {
            buddy!.unreadMessages.append(message)
        }
        
        self.tvBuddyList.reloadData()
    }
    
    func findBuddyByName(name:String) -> Buddy? {
        var buddy : Buddy?
        
        for b in self.buddies {
            if b.name == name {
                buddy = b
                break
            }
        }
        
        return buddy
    }
    
    func changeStatusButton(presence: Presence) {
        self.btnStatus.title = presence.isOnline ? "在线" : "离线"
        self.btnStatus.tintColor = presence.isOnline ? UIColor.greenColor() : UIColor.grayColor()
        
        self.btnLogin.title = presence.isOnline ? "切换用户" : "登录"
    }
    
    func changeNavigationTitle(presence: Presence) {
        self.navigationItem.title = presence.isOnline ? presence.name + "好友列表" : "请登录..."
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.buddies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : BuddyTableViewCell? = tableView.dequeueReusableCellWithIdentifier(BuddyTableViewCell.CELL_IDENTITY) as? BuddyTableViewCell
        if cell == nil {
            cell = BuddyTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: BuddyTableViewCell.CELL_IDENTITY)
        }
        
        cell!.render(self.buddies[indexPath.row])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var detailedViewController = ChatViewController(messages: self.buddies[indexPath.row].unreadMessages, buddy: self.buddies[indexPath.row])
        self.navigationController!.pushViewController(detailedViewController, animated: true)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class BuddyTableViewCell:UITableViewCell {
    
    static var CELL_IDENTITY = "BUDDY_CELL"
    
    var imgStatus:UIImageView!
    var labelName:UILabel!
    var buddy:Buddy!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(buddy:Buddy!) {
        if buddy == nil {
            return
        }
        
        self.buddy = buddy
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        var imgName = self.buddy.isOnline ? "online" : "offline"
        var image = UIImage(named:(imgName))
        if self.imgStatus == nil {
            self.imgStatus = UIImageView(image: image)
            self.imgStatus.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(self.imgStatus)
        } else {
            self.imgStatus.image = image
        }
        
        var unreadMsg = self.buddy.unreadMessages.count > 0 ? "(\(self.buddy.unreadMessages.count))" : ""
        var labelNameContent = self.buddy.name + unreadMsg
        if self.labelName == nil {
            self.labelName = UILabel()
            self.labelName.textColor=UIColor.blackColor()
            self.labelName.textAlignment = NSTextAlignment.Left
            self.labelName.text = labelNameContent
            self.labelName.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(self.labelName)
        } else {
            self.labelName.text = labelNameContent
        }
        
        let views = ["img": self.imgStatus, "label":self.labelName]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[img(==30)]-10-[label]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[img(==30)]-10-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[label(==30)]-10-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
}

