//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Roger Yee on 6/4/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var url = "http://api.k780.com:88/?app=weather.today&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        
        // Make a request and using Response Handler
        Alamofire.request(.GET, url).response {
            (_req, _resp, _data, _error) in
            println("----Make a request and using Response Handler-----")
            println(_data)
        }
        
        // Make a request and using ResponseJSON handler
        Alamofire.request(.GET, url).responseJSON {
            (_req, _resp, _data, _error) in
            println("----Make a request and using ResponseJSON handler-----")
            println(_data)
        }
        
        // Chained Response Handler
        Alamofire.request(.GET, url).responseJSON {
            (_req, _resp, _data, _error) in
            println("----Chained Response Handler-----")
            println(_data)
        }.responseString{
            (_req, _resp, _data, _error) in
            println("----Chained Response Handler-----")
            println(_data)
        }
        
        // GET Request with encoding Parameters
        var parmaters = ["app":"weather.today",
                         "weaid":"1",
                         "appkey":"10003",
                         "sign":"b59bc3ef6191eb9f747dd4e83c99f2a4",
                         "format":"json"
                        ]
        Alamofire.request(.GET, "http://api.k780.com:88", parameters:parmaters).responseJSON {
            (_req, _resp, _data, _error) in
            println("----GET Request with encoding Parameters-----")
            println(_data)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

