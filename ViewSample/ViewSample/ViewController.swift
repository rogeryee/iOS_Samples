//
//  ViewController.swift
//  ViewSample
//
//  Created by Roger Yee on 12/2/14.
//  Copyright (c) 2014 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // ActionSheet sample
    @IBOutlet weak var shareToLabel: UILabel!
    
    // ActionSheet sample
    @IBAction func shareTo(sender: AnyObject) {
        let actionSheet = UIActionSheet(
            title: nil,
            delegate: self,
            cancelButtonTitle: "取消",
            destructiveButtonTitle: "分享到新浪微博",
            otherButtonTitles:"分享到QQ空间"
        )
        
        actionSheet.showInView(self.view)
        
    }
    
    // ActionSheet sample
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        shareToLabel.text = actionSheet.buttonTitleAtIndex(buttonIndex)
    }
    
    // ActivityIndicator + AlertView sample
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // ActivityIndicator + AlertView sample
    @IBAction func startLoading(sender: AnyObject) {
        loadingIndicator.startAnimating()
    }
    
    // ActivityIndicator + AlertView sample
    @IBAction func stopLoading(sender: AnyObject) {
        
        let stopConfirmDialog = UIAlertView(
            title: "警告",
            message: "您确定要停止吗？",
            delegate: self,
            cancelButtonTitle: "否",
            otherButtonTitles: "是"
        )
        stopConfirmDialog.show()
    }
    
    // ActivityIndicator + AlertView sample
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            loadingIndicator.stopAnimating()
        }
    }
    
    // ImageView
    @IBOutlet weak var imageView1: UIImageView!
    @IBAction func playAnimation(sender: AnyObject) {
       
//        imageView1.animationImages = [
//            UIImage(named:"01")!,
//            UIImage(named:"02")!,
//            UIImage(named:"03")!
//        ]
        
        // Use 'map' closure instead of the code block above
        imageView1.animationImages = (1...3).map {
            UIImage(named:"0\($0)")!
        }
        
        imageView1.contentMode = .ScaleAspectFit
        imageView1.animationDuration = 1
        imageView1.startAnimating();
    }
    
    // PickerView
    @IBOutlet weak var pickerLabel0: UILabel!
    @IBOutlet weak var pickerLabel1: UILabel!
    @IBOutlet weak var pickerLabel2: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    let citys = ["北京","上海","广州"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citys.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return citys[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: pickerLabel0.text = citys[row]
        case 1: pickerLabel1.text = citys[row]
        default: pickerLabel2.text = citys[row]
        }
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

