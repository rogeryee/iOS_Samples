//
//  ViewController.swift
//  TabBarSample
//
//  Created by Roger Yee on 5/21/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func loadView() {
        super.loadView() 
        self.title = "首页"
        self.view.backgroundColor = UIColor.redColor()
    }
}

