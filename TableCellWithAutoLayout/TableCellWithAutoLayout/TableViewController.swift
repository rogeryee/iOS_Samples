//
//  ViewController.swift
//  TableCellWithAutoLayout
//
//  Created by Roger Yee on 6/10/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let cellId = "cid"
    var tableView:UITableView!
    
    var model = Model(populated: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.title = "iOS 8 Self Sizing Cells"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "clear")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRow")
        
        self.tableView = UITableView(frame: CGRectZero)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(CellWithAutoSizing.self, forCellReuseIdentifier: cellId)
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.allowsSelection = false
        
        // Enable AutoSizing features for the cell
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        self.view.addSubview(self.tableView)
        
        // Add Constraints
        var views = ["tableView": self.tableView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : CellWithAutoSizing? = tableView.dequeueReusableCellWithIdentifier(cellId) as? CellWithAutoSizing
        if cell == nil {
            cell = CellWithAutoSizing(style: UITableViewCellStyle.Default,reuseIdentifier: cellId)
        }
        
        let modelItem = model.dataArray[indexPath.row]
        cell!.render(modelItem.title, body: modelItem.body)
//        cell!.setNeedsUpdateConstraints()
//        cell!.updateConstraintsIfNeeded()
        return cell!
    }
    
    // Deletes all rows in the table view and replaces the model with a new empty one
    func clear()
    {
        let rowsToDelete: NSMutableArray = []
        for (var i = 0; i < model.dataArray.count; i++) {
            rowsToDelete.addObject(NSIndexPath(forRow: i, inSection: 0))
        }
        
        self.model = Model(populated: false)
        self.tableView.deleteRowsAtIndexPaths(rowsToDelete as [AnyObject], withRowAnimation: .Automatic)
    }
    
    // Adds a single row to the table view
    func addRow()
    {
        self.model.addSingleItem()
        
        let lastIndexPath = NSIndexPath(forRow: model.dataArray.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([lastIndexPath], withRowAnimation: .Automatic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CellWithAutoSizing : UITableViewCell {
    
    var titleLabel : UILabel!
    var bodyLabel : UILabel!
    
    func render(title : String, body : String) {
        
        if self.titleLabel == nil {
            self.titleLabel = UILabel()
            self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.titleLabel.numberOfLines = 1
            self.titleLabel.textAlignment = .Left
            self.titleLabel.textColor = UIColor.blackColor()
            self.titleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.1) // light blue
            self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.contentView.addSubview(self.titleLabel)
        }
        self.titleLabel.text = title
        
        if self.bodyLabel == nil {
            self.bodyLabel = UILabel()
            self.bodyLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.bodyLabel.numberOfLines = 0
            self.bodyLabel.textColor = UIColor.darkGrayColor()
            self.bodyLabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1) // light red
            self.bodyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.contentView.addSubview(self.bodyLabel)
        }
        self.bodyLabel.text = body
        
        self.contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1) // light green
//        self.contentView.layer.borderColor = UIColor.blackColor().CGColor
//        self.contentView.layer.borderWidth = 1
        
        let views = ["title":self.titleLabel, "body" : self.bodyLabel]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[title(<=25)]-5-[body]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[title]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[body]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
    }
}

