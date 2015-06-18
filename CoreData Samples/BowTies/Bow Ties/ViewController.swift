//
//  ViewController.swift
//  Bow Ties
//
//  Created by Pietro Rea on 6/25/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var managedContext : NSManagedObjectContext!
    
    var currentBowtie : Bowtie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 加载初始化数据
        insertSampleData()
        
        // 默认选中第一个领结
        fetchBowtie(segmentedControl.titleForSegmentAtIndex(0)!)
    }
    
    // 获取指定名称的领结
    func fetchBowtie(searchKey : String) {
        let request = NSFetchRequest(entityName: "Bowtie")
        request.predicate = NSPredicate(format: "searchKey == %@", searchKey)
        
        var error : NSError?
        let results = managedContext!.executeFetchRequest(request, error: &error)
        
        if let bowties = results {
            self.currentBowtie = bowties[0] as! Bowtie
            renderBowtie(self.currentBowtie)
        } else {
            println("无法获取数据 \(error), \(error?.userInfo)")
        }
    }
    
    // 显示指定的领结
    func renderBowtie(bowtie:Bowtie) {
        self.imageView.image = UIImage(data: bowtie.photoData)
        self.nameLabel.text = bowtie.name
        self.ratingLabel.text = "当前评分：\(bowtie.rating)"
        self.timesWornLabel.text = "戴了\(bowtie.timesWorn)次"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        self.lastWornLabel.text = "最近一次穿戴：" + dateFormatter.stringFromDate(bowtie.lastWorn)
        self.favoriteLabel.hidden = !bowtie.isFavorite.boolValue
        self.view.tintColor = bowtie.tintColor as! UIColor
    }
    
    // 切换领结
    @IBAction func segmentedControl(control: UISegmentedControl) {
        let title = control.titleForSegmentAtIndex(control.selectedSegmentIndex)
        fetchBowtie(title!)
    }
    
    // 穿戴一次领结
    @IBAction func wear(sender: AnyObject) {
        let times = self.currentBowtie.timesWorn.integerValue
        self.currentBowtie.timesWorn = NSNumber(integer: (times + 1))
        self.currentBowtie.lastWorn = NSDate()
        
        var error:NSError?
        if !managedContext.save(&error) {
            println("无法保存 \(error), \(error?.userInfo)")
        }
        
        renderBowtie(self.currentBowtie)
    }
    
    // 评分
    @IBAction func rate(sender: AnyObject) {
        let alert = UIAlertController(title: "新增评分", message:"为该领结评分", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler {
            (textField : UITextField!) in
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Default) {
            (action:UIAlertAction!) ->Void in
        }
        
        let saveAction = UIAlertAction(title: "评分", style: .Default) {
            (action:UIAlertAction!) ->Void in
            let rating = (alert.textFields![0] as! UITextField).text
            self.updateRating(rating)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateRating(rating : String) {
        self.currentBowtie.rating = (rating as NSString).doubleValue
        
        var error:NSError?
        if !managedContext.save(&error) {
            println("无法保存 \(error), \(error?.userInfo)")
            
            if error!.code == NSValidationNumberTooSmallError ||
                error!.code == NSValidationNumberTooLargeError {
                    rate(self.currentBowtie)
                    return
            }
        }
        
        renderBowtie(self.currentBowtie)
    }
    
    func insertSampleData() {
        
        let request = NSFetchRequest(entityName: "Bowtie")
        request.predicate = NSPredicate(format:"searchKey != nil")
        
        let count = managedContext.countForFetchRequest(request, error: nil)
        
        // 如果已经加载过数据，则返回
        if count > 0 {
            return
        }
        
        let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        
        for dict : AnyObject in dataArray! {
            let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
            
            let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext!)
            
            let btDic = dict as! NSDictionary
            
            bowtie.name = btDic["name"] as! String
            bowtie.searchKey = btDic["searchKey"] as! String
            bowtie.rating = btDic["rating"] as! NSNumber
            bowtie.lastWorn = btDic["lastWorn"] as! NSDate
            bowtie.timesWorn = btDic["timesWorn"] as! NSNumber
            bowtie.isFavorite = btDic["isFavorite"] as! NSNumber
            
            let imageName = btDic["imageName"] as! String
            let image = UIImage(named: imageName)
            let photoData = UIImagePNGRepresentation(image)
            bowtie.photoData = photoData
            
            bowtie.tintColor = colorFromDict((btDic["tintColor"] as! NSDictionary))
            
            var error : NSError?
            if !self.managedContext!.save(&error) {
                println("无法保存 \(error), \(error!.userInfo)")
            }
        }
    }
    
    func colorFromDict(dict : NSDictionary) -> UIColor {
        let red = dict["red"] as! NSNumber
        let green = dict["green"] as! NSNumber
        let blue = dict["blue"] as! NSNumber
        
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        
        return color
    }
}

