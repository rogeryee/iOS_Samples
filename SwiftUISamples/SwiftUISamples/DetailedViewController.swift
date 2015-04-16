//
//  DetailedViewController.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 12/5/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//
import UIKit

class DetailedViewController: UIViewController {
    var sample : String!
    var backToParentAction:Any!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //设置背景色
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"返回示例列表", style: UIBarButtonItemStyle.Bordered, target: self, action: "btnBackClicked:")
        
        self.loadSample(self.sample)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnBackClicked(sender:AnyObject) {
        let action = backToParentAction! as! ()->Void
        action()
    }
    
    func loadSample(sample:String) {
        switch sample {
        case "HelloWorld" : addView(HelloWorldSample(frame:self.view.bounds))
        case "ActionSheetView" : addView(ActionSheetSample(frame:self.view.bounds))
        case "ActivityIndicator + AlertView" : addView(ActivityIndicatorAndAlertSample(frame:self.view.bounds))
        case "ImageView" : self.view.addSubview(HelloWorldSample(frame:self.view.bounds))
        default : return
        }
    }
    
    func addView(view:UIView) {
        self.view.addSubview(view)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
