//
//  TravelLocationListTableViewController.swift
//  TravelList
//
//  Created by Roger Yee on 12/1/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class TravelLocationListTableViewController: UITableViewController {
    
    // 度假地列表
    var travelLocationList = [TravelLocation]()

    // 初始化旅游地列表的默认数据
    func initTravelLocationData() {
        let location1 = TravelLocation()
        location1.place = "芒市"
        travelLocationList.append(location1)
        
        let location2 = TravelLocation()
        location2.place = "稻城"
        travelLocationList.append(location2)
        
        let location3 = TravelLocation()
        location3.place = "阳朔"
        travelLocationList.append(location3)
        
        let location4 = TravelLocation()
        location4.place = "兰溪"
        travelLocationList.append(location4)
        
        let location5 = TravelLocation()
        location5.place = "竹海"
        travelLocationList.append(location5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        initTravelLocationData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
//        tableView.setEditing(editing, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return travelLocationList.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //删除数组所在行
            travelLocationList.removeAtIndex(indexPath.row)
            
            // 删除单元格所在行
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let location = travelLocationList[indexPath.row];
        cell.textLabel.text = location.place
        
        if location.isVisited {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        travelLocationList[indexPath.row].isVisited = !travelLocationList[indexPath.row].isVisited
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        tableView.reloadData()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToTravelLocationList(segue:UIStoryboardSegue) {
        let source = segue.sourceViewController as AddTravelLocationViewController
        
        let location = source.travelLocation
        
        if location.place != "" {
            travelLocationList.append(location)
        }
    }

}
