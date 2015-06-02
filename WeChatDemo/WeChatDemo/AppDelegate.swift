//
//  AppDelegate.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, XMPPStreamDelegate {

    var window: UIWindow?
    
    var xmlStream : XMPPStream?
    var isServerOn = false
    var pwd = ""
    
    var statusDelegate : StatusDelegate?
    
    var messageDelegate : WXMessageDelegate?
    
    func xmppStreamDidConnect(sender: XMPPStream!) {
        
        self.isServerOn = true
        
        self.xmlStream!.authenticateWithPassword(self.pwd, error: nil)
    }
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        goOnline()
    }
    
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        
        if message.isChatMessage() {
            var msg = WXMessage()
            
            if message.elementForName("composing") != nil {
                msg.isComposing = true // 对方正在输入
            }
            
            if message.elementForName("delay") != nil {
                msg.isDelay = true // 离线消息
            }
            
            if let body = message.elementForName("body") {
                msg.body = body.stringValue() // 正文
            }
            
            msg.from = message.from().user + "@" + message.from().domain
            
            self.messageDelegate?.receiveMessage(msg)
        }
    }
    
    // 收到状态信息
    func xmppStream(sender: XMPPStream!, didSendPresence presence: XMPPPresence!) {
        
        let mine = sender.myJID.user // 自己的用户名
        let fromUser = presence.from().user // 好友用户名
        let fromDomain = presence.from().domain // 好友所在的域
        let type = presence.type()
        
        // 状态信息不是自己的
        if (fromUser != mine) {
            
            var status = Status(name: fromUser + "@" + fromDomain)
            
            // 上线
            if type == "available" {
                status.isOnline = true
                self.statusDelegate?.online(status)
            } else if type == "unavailable" {
                status.isOnline = false
                self.statusDelegate?.online(status)
            }
        }
    }
    
    func buildStream() {
        self.xmlStream = XMPPStream()
        self.xmlStream?.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    
    func goOnline() {
        var p = XMPPPresence()
        self.xmlStream!.sendElement(p)
    }
    
    func goOffline() {
        var p = XMPPPresence(name: "unavailable")
        self.xmlStream!.sendElement(p)
    }
    
    func connectToServer() -> Bool{
        buildStream()
        
        if xmlStream!.isConnected() {
            return true
        }
        
        let user = NSUserDefaults.standardUserDefaults().stringForKey("wechatID")
        let pwd = NSUserDefaults.standardUserDefaults().stringForKey("wechatPwd")
        let server = NSUserDefaults.standardUserDefaults().stringForKey("wechatServer")
        
        if (user != nil && pwd != nil) {
            self.xmlStream?.myJID = XMPPJID.jidWithString(user!)
            self.pwd = pwd!
            
            self.xmlStream?.connectWithTimeout(5000, error: nil)
        }
        
        return false
    }
    
    func disconnect() {
        goOffline()
        self.xmlStream?.disconnect()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var buddyListViewController = BuddyListViewController()
        var navigation = UINavigationController(rootViewController: buddyListViewController)
        self.window?.rootViewController = navigation
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

