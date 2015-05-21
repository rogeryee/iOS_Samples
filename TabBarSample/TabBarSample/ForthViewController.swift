//
//  ForthViewController.swift
//  TabBarSample
//
//  Created by Roger Yee on 5/21/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.purpleColor()
        self.title = "设置"
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