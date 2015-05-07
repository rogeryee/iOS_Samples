//
//  WebBrowserSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 5/6/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class WebBrowserSample: SampleView, UIWebViewDelegate, UITextFieldDelegate  {
    
    var textfield: UITextField!
    var webview: UIWebView!
    var activitor: UIActivityIndicatorView!
    
    override func loadView() {
        
        textfield = UITextField()
        textfield.placeholder = "请输入网址"
        textfield.clearButtonMode = UITextFieldViewMode.Always
        textfield.setTranslatesAutoresizingMaskIntoConstraints(false)
        textfield.delegate = self
        self.addSubview(textfield)
        
        webview = UIWebView()
        webview.delegate = self
        webview.scalesPageToFit = true
        webview.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(webview)
        
        activitor = UIActivityIndicatorView()
        activitor.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activitor.color = UIColor.blueColor()
        activitor.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(activitor)
        
        // Constraints
        let views = ["textfield": textfield,"webview":webview,"activitor":activitor]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[textfield]-[webview]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[textfield]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webview]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
        self.addConstraints([NSLayoutConstraint(item: activitor, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.addConstraints([NSLayoutConstraint(item: activitor, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)])
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