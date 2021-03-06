//
//  ViewController.swift
//  TabBarSample
//
//  Created by Roger Yee on 5/21/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // 设置TabBar的显示名字，需要在构造方法中声明，这样才能在程序打开时显示在TabBar上
        // 如果将self.title="历史"放在viewDidLoad中，而在程序启动时，TabBar上并不会显示“历史”，只有当用户切换到该页面时，程序才会触发viewDidLoad方法
        self.title = "历史"
        self.view.backgroundColor = UIColor.yellowColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

