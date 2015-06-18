//
//  ViewController.swift
//  HitList
//
//  Created by Roger Yee on 6/15/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableview : UITableView!
    
    var people = [NSManagedObject]() // Core data

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "姓名列表"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addItem"))
        
        self.tableview = UITableView()
        self.tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tableview)
        
        let views = ["table":self.tableview]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
        self.tableview.reloadData()
    }
    
    func addItem() {
        var alert = UIAlertController(title: "添加新姓名", message: "请输入一个姓名", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action:UIAlertAction!) ->Void in
            let textField = alert.textFields![0] as! UITextField
            
            self.saveName(textField.text)
            
            let indexPath = NSIndexPath(forRow: self.people.count-1, inSection: 0)
            self.tableview.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action:UIAlertAction!) ->Void in
        }
        
        alert.addTextFieldWithConfigurationHandler{
            (textField:UITextField!) ->Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveName(name:String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        person.setValue(name, forKey: "name")
        
        var error : NSError?
        if !managedContext.save(&error) {
            println("无法保存\(error), \(error?.userInfo)")
        }
        
        people.append(person)
    }
    
    func loadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Person")
        
        var error : NSError?
        let fetchedResult = managedContext.executeFetchRequest(request, error: &error)
        
        if let result = fetchedResult {
            people = result as! [NSManagedObject]
        } else {
            println("无法获取数据 \(error), \(error?.userInfo)")
        }
    }
    
    // MASK : UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("CELL") as! UITableViewCell
        
        let person = self.people[indexPath.row];
        cell.textLabel!.text = (person.valueForKey("name") as! String)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

