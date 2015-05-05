//
//  WebViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/27/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class WebViewSample: SampleView,UIWebViewDelegate {
    
    var loadType : UISegmentedControl!
    var webview : UIWebView!
    
    override func loadView() {
        
        loadType=UISegmentedControl(items:["显示HTML","百度","本地文件","loadData"])
        loadType.center = CGPoint(x:self.center.x, y:100)
        loadType.addTarget(self, action: "typeChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(loadType)
        
        webview = UIWebView(frame: CGRectMake(0, 150, 400,500))
        webview.delegate = self
        webview.scalesPageToFit = true
        self.addSubview(webview)
        
        loadType.selectedSegmentIndex = 0
        typeChanged(loadType)
    }
    
    func typeChanged(segmented:UISegmentedControl){
        //获得选项的索引
        println(segmented.selectedSegmentIndex)
        //获得选择的文字
        println(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
        
        var index = segmented.selectedSegmentIndex
        switch index {
        case 0:
            var html = "<h1>欢迎使用百度</h1>"
            webview.loadHTMLString(html, baseURL: nil)
        case 1:
            webview.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!))
        case 2:
            var path = NSBundle.mainBundle().pathForResource("testFile", ofType: "txt")
            var url = NSURL.fileURLWithPath(path!)
            webview.loadRequest(NSURLRequest(URL:url!))
//        case 3:
//            var path = NSBundle.mainBundle().pathForResource("testFile", ofType: "txt")
//            var url = NSURL.fileURLWithPath(path!)
//            var data = NSData(contentsOfFile: url)
//            webview.loadData(data, MIMEType: "application/txt", textEncodingName: "utf-8", baseURL: nil)
        default:
            println()
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("Webview started Loading")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        println("Webview did finish load")
    }
}