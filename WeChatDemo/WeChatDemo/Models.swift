//
//  Models.swift
//  WeChatDemo
//
//  Created by Roger Yee on 5/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

//class User {
//    var name : String!
//    var logo : String!
//    
//    init(name:String, logo:String) {
//        self.name = name
//        self.logo = logo
//    }
//}

// 与服务端通讯消息格式类
class WXMessage {
    var body = ""
    var from = ""
    var isComposing = false
    var isDelay = false
    var isFromMe = false
}

class Status {
    var name : String = ""
    var isOnline : Bool = false
    
    init(name:String) {
        self.name = name
    }
}