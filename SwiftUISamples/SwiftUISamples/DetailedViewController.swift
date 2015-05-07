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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"返回示例列表", style: UIBarButtonItemStyle.Plain, target: self, action: "btnBackClicked:")
        
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
        
        var view:SampleView!;
        
        switch sample {
        case "HelloWorld" : view = HelloWorldSample()
        case "Button" : view = ButtonSample()
        case "Text Field" : view = TextSample()
        case "Switch" : view = SwitchSample()
        case "Segmented Control" : view = SegmentedControlSample()
        case "ActionSheetView" : view = ActionSheetSample()
        case "ActivityIndicator + AlertView" : view = ActivityIndicatorAndAlertSample()
        case "ImageView" : view = ImageViewSample()
        case "Progress" : view = ProgressSample()
        case "Slider" : view = SliderSample()
        case "PickView" : view = PickViewSample()
        case "Stepper" : view = StepperSample()
        case "Scroll View" : view = ScrollViewSample()
        case "Date Picker" : view = DatePickerSample()
        case "Web View" : view = WebViewSample()
        case "Web Browser" : view = WebBrowserSample()
        case "NSLayoutConstraint" : view = NSLayoutConstraintSample()
        default : return
        }
        
        view.loadView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        addView(view)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[view]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["view":view]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["view":view]))
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
