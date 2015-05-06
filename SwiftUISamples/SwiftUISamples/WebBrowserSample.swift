//
//  WebBrowserSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 5/6/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class WebBrowserSample: SampleView,UIWebViewDelegate {
    
    var textfield: UITextField!
    var webview: UIWebView!
    var activitor: UIActivityIndicatorView!
    
    override func loadView() {
        
//        textfield = UITextField(frame: CGRectMake(0, 160, 200,30))
//        textfield = UITextField()
//        textfield.borderStyle = UITextBorderStyle.RoundedRect
//        textfield.placeholder="请输入网址"
//        textfield.adjustsFontSizeToFitWidth=true
//        textfield.minimumFontSize=14
//        textfield.returnKeyType = UIReturnKeyType.Search
//        textfield.clearButtonMode=UITextFieldViewMode.Always
//        self.addSubview(textfield)
        
        var textfield = UILabel(frame: CGRectMake(0, 160, 200,30))
        textfield.textColor=UIColor.whiteColor()
        textfield.backgroundColor=UIColor.blackColor()
        textfield.textAlignment = NSTextAlignment.Center
        textfield.font = UIFont(name:"Zapfino", size:20)
        textfield.text = "Hello Roger!"
        textfield.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(textfield)
        
        var constraints = [NSLayoutConstraint]()
        NSLayoutConstraint.constraintsWithVisualFormat("|-[textfield]-|",options:NSLayoutFormatOptions.allZeros,metrics: nil,views: ["textfield": textfield]).map {
            constraints.append($0 as! NSLayoutConstraint)
        }
        NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[textfield(==30)]",options:NSLayoutFormatOptions.allZeros,metrics: nil,views: ["textfield": textfield]).map {
            constraints.append($0 as! NSLayoutConstraint)
        }
        self.addConstraints(constraints)
        
        
//        webview = UIWebView(frame: CGRectMake(0, 150, 400,500))
//        webview.delegate = self
//        webview.scalesPageToFit = true
//        self.addSubview(webview)
    }
}