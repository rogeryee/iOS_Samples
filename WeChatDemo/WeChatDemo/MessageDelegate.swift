//
//  WXMessageDelegate.swift
//  WeChatDemo
//
//  Created by Roger Yee on 6/2/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

protocol MessageDelegate {
    func receiveMessage(message : Message)
}