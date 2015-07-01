//
//  ViewController.swift
//  CoreGraphicDemo
//
//  Created by Roger Yee on 6/28/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var containerView:ContainerView!
    var pushPlusButton:UIPushButton!
    var pushMinusButton:UIPushButton!
    
    var isGraphicViewShowing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var gesture = UITapGestureRecognizer(target: self, action: Selector("counterViewTap:"))
        gesture.numberOfTapsRequired = 1
        
        self.containerView = ContainerView()
        self.containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.containerView.addGestureRecognizer(gesture)
        self.view.addSubview(self.containerView)
        
        let plusColor = UIColor(red: 87/255, green: 218/255, blue: 213/255, alpha: 1)
        self.pushPlusButton = UIPushButton(fillColor: plusColor, isPlusType: true)
        self.pushPlusButton.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.pushPlusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.pushPlusButton)
        
        let minusColor = UIColor(red: 238/255, green: 77/255, blue: 77/255, alpha: 1)
        self.pushMinusButton = UIPushButton(fillColor: minusColor, isPlusType: false)
        self.pushMinusButton.addTarget(self, action: "btnPushButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.pushMinusButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.pushMinusButton)
        
        let views = ["container":self.containerView, "plus":self.pushPlusButton, "minus":self.pushMinusButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[container(==300)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[container(==250)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.containerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.containerView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -150.0))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[plus(==100)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[plus(==100)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.pushPlusButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushPlusButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 80.0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[minus(==60)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[minus(==60)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushMinusButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pushMinusButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 200.0))
    }

    func btnPushButton(button: UIPushButton) {
        if button.isPlusType! {
            self.containerView.counterView.increaseCounter()
        } else {
            self.containerView.counterView.decreaseCounter()
        }
        
        if isGraphicViewShowing {
            counterViewTap(nil)
        }
    }
    
    func counterViewTap(sender:UITapGestureRecognizer?) {
        if isGraphicViewShowing {
            UIView.transitionFromView(self.containerView.graphicView, toView: self.containerView.counterView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft | UIViewAnimationOptions.ShowHideTransitionViews, completion: nil)
        } else {
            UIView.transitionFromView(self.containerView.counterView, toView: self.containerView.graphicView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight | UIViewAnimationOptions.ShowHideTransitionViews, completion: nil)
        }
        
        isGraphicViewShowing = !isGraphicViewShowing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class ContainerView:UIView {
    
    var counterView:UICounterView!
    var graphicView:UIGraphicView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        self.counterView = UICounterView()
        self.counterView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.counterView)
        
        self.graphicView = UIGraphicView()
        self.graphicView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.graphicView)
        
        let views = ["counter":self.counterView, "placeholder":self.graphicView]
        
        // Constraints of Counter
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[counter(==230)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[counter(==230)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: self.counterView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.counterView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        
        // Constraints of Graphic Placeholder
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[placeholder(==300)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[placeholder(==250)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: self.graphicView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.graphicView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

