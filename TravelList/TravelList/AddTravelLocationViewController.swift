//
//  AddTravelLocationViewController.swift
//  TravelList
//
//  Created by Roger Yee on 12/1/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class AddTravelLocationViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var locationInputField: UITextField!
    var travelLocation = TravelLocation()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if sender as NSObject == doneButton {
            if(!locationInputField.text.isEmpty) {
                travelLocation.place = locationInputField.text
            }
        }
    }
}
