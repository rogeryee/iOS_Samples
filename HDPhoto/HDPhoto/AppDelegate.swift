//
//  AppDelegate.swift
//  HDPhoto
//
//  Created by Roger Yee on 5/25/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setGlobalStyles(application)
        
        loadView()
        
        return true
    }
    
    func loadView() {
        // First Tab
        var photoBrowserViewController = PhotoBrowserViewController()
        var browserItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 1)
        photoBrowserViewController.tabBarItem = browserItem
        
        var firstNavigationVC = UINavigationController(rootViewController: photoBrowserViewController)
        
        // Second Tab
        var downloadPhotoBrowserViewController = DownloadPhotoBrowserViewController()
        var downloadItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Downloads, tag: 1)
        downloadPhotoBrowserViewController.tabBarItem = downloadItem
        
        var secondNavigationVC = UINavigationController(rootViewController: downloadPhotoBrowserViewController)
        
        // Add tabs to TabController
        var tabBarController = TabBarController()
        tabBarController.setViewControllers([firstNavigationVC, secondNavigationVC], animated: true)
        
        self.window?.rootViewController = tabBarController
    }
    
    func setGlobalStyles(application: UIApplication) {
        UINavigationBar.appearance().barStyle = .BlackTranslucent
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UIToolbar.appearance().barStyle = .BlackTranslucent
        UITabBar.appearance().barStyle = .Black
        UITabBar.appearance().translucent = true
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        
        UIButton.appearance().tintColor = UIColor.whiteColor()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

