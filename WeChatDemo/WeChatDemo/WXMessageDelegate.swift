//
//  WXMessageDelegate.swift
//  WeChatDemo
//
//  Created by Roger Yee on 6/2/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

protocol WXMessageDelegate {
    func newMessage(message : WXMessage)
    func receiveMessage(message : WXMessage)
}