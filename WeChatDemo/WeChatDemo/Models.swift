//
//  Models.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

class UserViewModel {
    var name : String = ""
    var isOnline : Bool = false
    
    init(name:String) {
        self.name = name
    }
}

class Buddy : UserViewModel {
    var unreadMessageNumber = 0
}

// 与服务端通讯消息格式类
class WXMessage {
    var body = ""
    var from = ""
    var isComposing = false
    var isDelay = false
    var isFromMe = false
}

class Presence {
    var name : String = ""
    var isOnline : Bool = false
    
    init(name:String) {
        self.name = name
    }
}