//
//  TabBarViewController.swift
//  TabBar_NavigationSample
//
//  Created by Roger Yee on 5/22/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class TabBarViewController : UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBar.hidden = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        loadCustomTabBar()
    }
    
    func loadCustomTabBar() {
        
        var bgView = UIImageView()
        bgView.image = UIImage(named: "tabBar")
        bgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(bgView)
        
        let views = ["bg":bgView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bg]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bg(==70)]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
    }
}