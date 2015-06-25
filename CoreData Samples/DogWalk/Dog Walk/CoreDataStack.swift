//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Roger Yee on 6/18/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    var context : NSManagedObjectContext
    var coordindator : NSPersistentStoreCoordinator
    var model : NSManagedObjectModel
    var store : NSPersistentStore?
    
    func applicationDocumentDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
        
        return urls[0]
    }
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Dog Walk", withExtension: "momd")
        
        self.model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        self.coordindator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        
        self.context = NSManagedObjectContext()
        self.context.persistentStoreCoordinator = self.coordindator
        
        let documentURL = applicationDocumentDirectory()
        let storeURL = documentURL.URLByAppendingPathComponent("Dog Walk")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption:true]
        var error : NSError?
        self.store = self.coordindator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error)
        
        if store == nil {
            println("无法添加存储 \(error)")
            abort()
        }
    }
    
    func saveContext() {
        var error : NSError? = nil
        if self.context.hasChanges && !self.context.save(&error) {
            println("无法保存\(error)")
        }
    }
    
}

