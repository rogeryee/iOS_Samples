//
//  ScrollViewSample.swift
//  SwiftUISamples
//
//  Created by Roger Yee on 4/22/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ScrollViewSample: SampleView, UIScrollViewDelegate {
    
    override func loadView() {
        
        var scrollView=UIScrollView()
        scrollView.frame=self.bounds
        // 滚动条的风格
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black;
        
        // 支持缩放
        scrollView.minimumZoomScale=0.1
        scrollView.maximumZoomScale=3
        scrollView.delegate=self
        
        var imageView=UIImageView(image:UIImage(named:"man-utd"))
        scrollView.contentSize=imageView.bounds.size;
        scrollView.addSubview(imageView);
        
        self.addSubview(scrollView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        for subview : AnyObject in scrollView.subviews {
            if subview.isKindOfClass(UIImageView) {
                return subview as? UIView
            }
        }
        
        return nil
    }
}
