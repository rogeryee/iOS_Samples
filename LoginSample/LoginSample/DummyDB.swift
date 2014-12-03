//
//  DummyDB.swift
//  LoginSample
//
//  Created by Roger Yee on 11/28/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

public class DummyDB {
    private var data:[String:String]?
    
    init() {
        initData()
    }
    
    private func initData() {
        data = ["test":"123","roger":"123"]
    }
    
    public func getUser(name:String) -> String? {
        return data![name]
    }
}

//public class User {
//    private var name:String?
//    private var password:String?
//}
