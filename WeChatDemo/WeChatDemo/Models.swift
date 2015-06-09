//
//  Models.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

enum ChatType {
    case Mine
    case Other
}

class User {
    var name : String = ""
    var fullName : String = "" // with domain
    var domain : String = ""
    var isOnline : Bool = false
    var logo : String = "xiaoming"
    
    init(name:String, domain:String) {
        self.name = name
        self.domain = domain
        self.fullName = self.name + "@" + self.domain
    }
}

class Buddy : User {
    var unreadMessages = [Message]()
    
    func resetUnreadMessages() {
        self.unreadMessages.removeAll(keepCapacity: false)
    }
}

// 与服务端通讯消息格式类
class Message {
    var from : User!
    var isComposing = false
    var isDelay = false
    var isFromMe = false
    var date = NSDate()
}

class TextMessage : Message {
    var body = ""
}

class Presence {
    var name : String = ""
    var isOnline : Bool = false
    
    init(name:String) {
        self.name = name
    }
}