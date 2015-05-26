//
//  PhotoBrowserViewController.swift
//  HDPhoto
//
//  Created by Roger Yee on 5/25/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import Alamofire

class PhotoBrowserViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
    let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"
    
    var collectionView : UICollectionView!
    
    var photos = NSMutableOrderedSet()
    
    var isLoadingPhotos = false
    var currentPage = 1;
    
    override func viewDidLoad() {
        renderView()
        loadPhotos()
        // https://api.500px.com/v1/photos?consumer_key=j9LaCoiMIW1mcNgEhLpFfE6KrKieijb5QKZM5JiS
    }
    
    func loadPhotos() {
        println("load photos")
        
        if self.isLoadingPhotos {
            return
        }
        
        self.isLoadingPhotos = true
        
        Alamofire.request(Router.PopularPhotos(currentPage)).responseJSON {(_, _, json, _) in
            
            if let j = json as? NSDictionary {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {()->Void in
                    
                    // 将nsfw＝true的图片过滤掉
                    var safePhotos = j.valueForKey("photos") as! [NSDictionary]
                    safePhotos = safePhotos.filter {
                        $0["nsfw"] as! Bool == false
                    }
                    
                    let newPhotos = safePhotos.map {
                        PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
                    }
                    
                    let lastIndex = self.photos.count
                    self.photos.addObjectsFromArray(newPhotos)
                    
                    let indexPaths = (lastIndex..<self.photos.count).map {
                        NSIndexPath(forItem: $0, inSection: 0)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.collectionView.insertItemsAtIndexPaths(indexPaths)
                        self.currentPage++
                        self.isLoadingPhotos = false
                    })
                    
                    // 不需要全部刷新，只需加在新增的图片即可
//                    self.collectionView.reloadData()
                })
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + self.view.frame.height > scrollView.contentSize.height * 0.8) {
            loadPhotos()
        }
    }
    
    func renderView() {
        
        // 为了避免出现第一行cell和collectionView之间的空档
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Navigation Bar
        let titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 30.0))
        titleLabel.text = "高清美图 - 精选"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.navigationItem.titleView = titleLabel
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.size.width - 4) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 2.0
        layout.minimumLineSpacing = 2.0
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
//        layout.footerReferenceSize = CGSize(width: self.view!.bounds.size.width, height: 20.0)
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
//        self.collectionView!.registerClass(PhotoBrowserCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoBrowserFooterViewIdentifier)        
//        self.collectionView.layer.borderColor = UIColor.whiteColor().CGColor
//        self.collectionView.layer.borderWidth = 1
        self.view.addSubview(self.collectionView)
        
        let views = ["collection":self.collectionView]
        let metrics = ["footHeight":(self.tabBarController?.tabBar.frame.height)!, "headHeight":(self.navigationController?.navigationBar.frame.height)!]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collection]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-headHeight-[collection]-footHeight-|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
        
        let photo = self.photos.objectAtIndex(indexPath.row) as! PhotoInfo
        let imageURL = photo.url
        cell.imageView.image = nil
        
        cell.request = Alamofire.request(.GET, imageURL).responseImage { (req,_,image,_) -> Void in
            if let img = image {
                if req.URLString == cell.request?.request.URLString {
                    cell.imageView.image = img
                }
            }
        }
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath) as! UICollectionReusableView
//    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


class PhotoBrowserCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    var request:Request!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        imageView.frame = bounds
        addSubview(imageView)
    }
}


class PhotoBrowserCollectionViewLoadingCell: UICollectionReusableView {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        spinner.startAnimating()
        spinner.center = self.center
        addSubview(spinner)
    }
}

