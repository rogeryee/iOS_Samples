//
//  ViewController.swift
//  Dog Walk
//
//  Created by Pietro Rea on 7/10/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
//    var walks:Array<NSDate> = []
    
    var currentDog : Dog!
    
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        
        let entity = NSEntityDescription.entityForName("Dog", inManagedObjectContext: context)
//        let dog = Dog(entity: entity!, insertIntoManagedObjectContext: context)
        
        let dogName = "xiaobai"
        let dogFetch = NSFetchRequest(entityName: "Dog")
        dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
        
        var error : NSError?
        
        let result = context.executeFetchRequest(dogFetch, error: &error) as! [Dog]?
        if let dogs = result {
            
            if dogs.count == 0 {
                let newDog = Dog(entity: entity!, insertIntoManagedObjectContext: context)
                newDog.name = dogName
                
                if !context.save(&error) {
                    println("无法保存 \(error)")
                }
                
            } else {
                self.currentDog = dogs[0]
            }
            
        } else {
            println("无法获取 \(error)")
        }
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        var walks = 0
        if let dog = self.currentDog {
            walks = dog.walks.count
        }
        
        return walks;
    }
    
    func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
            return "List of Walks";
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell",
                forIndexPath: indexPath) as! UITableViewCell
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .MediumStyle
            dateFormatter.doesRelativeDateFormatting = true
            dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
            
            let walk: AnyObject? =  currentDog!.walks[indexPath.row]
            
            cell.textLabel!.text = dateFormatter.stringFromDate((walk?.date)!)
            
            return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
        
            let walkToRemove = self.currentDog.walks[indexPath.row] as! Walk
            
            let walks = self.currentDog.walks.mutableCopy() as! NSMutableOrderedSet
            walks.removeObjectAtIndex(indexPath.row)
            currentDog.walks = walks.copy() as! NSOrderedSet
            
            self.context.deleteObject(walkToRemove)
            
            var error:NSError?
            if !self.context.save(&error) {
                println("无法保存 \(error)")
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    @IBAction func add(sender: AnyObject) {
        
        let entity = NSEntityDescription.entityForName("Walk", inManagedObjectContext: context)
        let walk = Walk(entity: entity!, insertIntoManagedObjectContext: context)
        
        walk.date = NSDate()
        
        var walks = self.currentDog.walks.mutableCopy() as! NSMutableOrderedSet
        walks.addObject(walk)
        
        currentDog.walks = walks.copy() as! NSOrderedSet
        
        var error: NSError?
        if !context!.save(&error) {
            println("Could not save: \(error)")
        }
        
        tableView.reloadData()
    }
    
}

