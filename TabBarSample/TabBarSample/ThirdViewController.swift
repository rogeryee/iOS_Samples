//
//  ThirdViewController.swift
//  TabBarSample
//
//  Created by Roger Yee on 5/21/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.blueColor()
        self.title = "搜索"
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}