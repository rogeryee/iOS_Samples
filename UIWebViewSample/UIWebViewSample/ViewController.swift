//
//  ViewController.swift
//  UIWebViewSample
//
//  Created by Roger Yee on 4/27/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var activitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Loading URL
    func loadURL(urlStr:String, webview:UIWebView) {
        let url = NSURL(string:("http://"+urlStr))
        let request = NSURLRequest(URL: url!)
        webview.loadRequest(request)
    }
    
    // 加载网页开始
    func webViewDidStartLoad(webView: UIWebView) {
        activitor.startAnimating()
        
        // 状态栏上的网络齿轮
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    // 加载网页结束
    func webViewDidFinishLoad(webView: UIWebView) {
        activitor.stopAnimating()
        
        // 状态栏上的网络齿轮
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        loadURL(textfield.text, webview: webview)
        // 收起键盘
        textfield.resignFirstResponder()
        return true
    }
    
}

