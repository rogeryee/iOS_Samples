//
//  SampleListViewController.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/5/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class SampleListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var samples = [
        "HelloWorld",
        "Button",
        "Text Field",
        "Switch",
        "Segmented Control",
        "ImageView",
        "Progress",
        "Slider",
        "ActionSheetView",
        "ActivityIndicator + AlertView",
        "PickView",
        "Stepper",
        "Scroll View",
        "Date Picker",
        "Web View",
        "Web Browser",
        "NSLayoutConstraint",
        "TableView(WeChat)"
    ]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Swift控件示例"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        self.tableView.scrollEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.samples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = self.samples[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var detailedViewController = DetailedViewController()
        detailedViewController.sample = self.samples[indexPath.row]
        detailedViewController.backToParentAction = backToSampleListViewCtrl
        self.navigationController!.pushViewController(detailedViewController, animated: true)
    }
    
    func backToSampleListViewCtrl()->Void {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
