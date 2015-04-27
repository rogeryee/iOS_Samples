//
//  ViewController.swift
//  UIWebViewSample
//
//  Created by Roger Yee on 4/27/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadType: UISegmentedControl!
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadType.selectedSegmentIndex = 0;
        typeChanged(loadType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func typeChanged(sender: UISegmentedControl) {
        
        
    }

}

