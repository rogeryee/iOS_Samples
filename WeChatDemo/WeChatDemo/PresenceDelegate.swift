//
//  StatusDelegate.swift
//  WeChatDemo
//
//  Created by Roger Yee on 6/2/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import Foundation

protocol PresenceDelegate {
    func buddyOnline(presence : Presence)
    func buddyOffline(presence : Presence)
    func selfOnline(presence : Presence)
    func selfOffline(presence : Presence)
}
