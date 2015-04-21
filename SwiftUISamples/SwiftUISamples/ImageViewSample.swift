//
//  ImageViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/20/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ImageViewSample: SampleView {
    
    var imageView:UIImageView!
    
    override func loadView() {
        
        // Do any additional setup after loading the view, typically from a nib.
        imageView=UIImageView(image:UIImage(named:"nike-01"))
        imageView.frame=CGRectMake(10,200,100,100)

        imageView.animationImages=[UIImage(named:"nike-01")!,UIImage(named:"nike-02")!, UIImage(named:"nike-03")!] as [AnyObject]
        imageView.animationDuration=1.0
        self.addSubview(imageView);
        
        imageView.startAnimating()
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        imageView.startAnimating();
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillAppear(animated)
//        super.viewWillAppear(animated)
//    }
    
    
}