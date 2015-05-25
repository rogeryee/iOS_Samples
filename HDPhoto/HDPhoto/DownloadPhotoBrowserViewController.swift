//
//  DownloadPhotoBrowserViewController.swift
//  HDPhoto
//
//  Created by Roger Yee on 5/25/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

class DownloadPhotoBrowserViewController : UIViewController {
    
    override func viewDidLoad() {
        renderView()
    }
    
    func renderView() {
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = "高清美图 - 下载"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.navigationItem.titleView = titleLabel
    }
}