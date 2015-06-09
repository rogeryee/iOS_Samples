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
    
    // Delegates
    var presenceDelegate : PresenceDelegate?
    var messageDelegate : MessageDelegate?
    
    var xmppStream : XMPPStream?
    var isConnectedToServer = false
    
    func getLoginUser() -> String {
        return (self.xmppStream?.myJID.user)!
    }
    
    func getDomain() -> String {
        return (self.xmppStream?.myJID.domain)!
    }
    
    func isLoginUser(name : String) -> Bool {
        return (name == self.xmppStream?.myJID.user)
    }
    
    func xmppStreamDidConnect(sender: XMPPStream!) {
        println("xmppStreamDidConnect \(self.xmppStream?.isConnected())")
        
        self.isConnectedToServer = true
        var pwd = NSUserDefaults.standardUserDefaults().stringForKey(Constants.KEY_PASSWORD)
        
        var error : NSError?
        self.xmppStream!.authenticateWithPassword(pwd, error: &error)
        
        if error != nil {
            println(error)
        }
    }
    
    func xmppStream(sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
        println("didReceiveError \(error)")
    }
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        println("xmppStreamDidAuthenticate")
        goOnline()
    }
    
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        println(error)
    }
    
    // 收到聊天消息
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        
        //println("didReceiveMessage \(message)")
        
        if message.isChatMessage() {
            var msg = TextMessage()
            
            if message.elementForName("composing") != nil {
                msg.isComposing = true // 对方正在输入
            }
            
            if message.elementForName("delay") != nil {
                msg.isDelay = true // 离线消息
            }
            
            if let body = message.elementForName("body") {
                msg.body = body.stringValue() // 正文
            }
            
            msg.from = User(name: message.from().user, domain: self.getDomain())
            msg.from.logo = isLoginUser(message.from().user) ? "xiaoming" : "xiaohua"
            
            self.messageDelegate?.receiveMessage(msg)
        }
    }
    
    // 收到状态信息
    func xmppStream(sender: XMPPStream!, didReceivePresence presence: XMPPPresence!) {
        
        println("didReceivePresence")
        let mine = sender.myJID.user // 自己的用户名
        let fromUser = presence.from().user // 好友用户名
        let fromDomain = presence.from().domain // 好友所在的域
        let type = presence.type()
        
        var presence = Presence(name: fromUser)
        presence.isOnline = type == "available" ? true : false
        
        // 好友状态
        if (fromUser != mine) {
            switch presence.isOnline {
            case true:
                self.presenceDelegate?.buddyOnline(presence)
            default:
                self.presenceDelegate?.buddyOffline(presence)
            }
        } else {
            // 自己状态
            switch presence.isOnline {
            case true:
                self.presenceDelegate?.selfOnline(presence)
            default:
                self.presenceDelegate?.selfOffline(presence)
            }
        }
    }
    
    func setupXMPPStream() {
        self.xmppStream = XMPPStream()
        self.xmppStream?.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    
    func goOnline() {
        var p = XMPPPresence(type: "available")
        self.xmppStream!.sendElement(p)
    }
    
    func goOffline() {
        var p = XMPPPresence(type: "unavailable")
        self.xmppStream!.sendElement(p)
    }
    
    func sendMessage(element : DDXMLElement) {
        self.xmppStream!.sendElement(element)
    }
    
    func connectToServer() -> Bool{
        
        setupXMPPStream()
        
        if self.xmppStream!.isConnected() {
            return true
        }
        
        var defaults = NSUserDefaults.standardUserDefaults();
        var user = defaults.stringForKey(Constants.KEY_USER_ID)
        var server = defaults.stringForKey(Constants.KEY_SERVER)
        
        if ((user == nil || user == "") && (server == nil || server == "")) {
            return false
        }
        
        self.xmppStream?.myJID = XMPPJID.jidWithString(user)
        self.xmppStream?.hostName = server
        
        var error : NSError?
        if ((self.xmppStream?.connectWithTimeout(5000, error: &error)) == nil) {
            println("Cannot connect to Server (\(server)), error is (error!)")
            return false
        }
        
        return true
    }
    
    func disconnect() {
        goOffline()
        self.xmppStream?.disconnect()
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

