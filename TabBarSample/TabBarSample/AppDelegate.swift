//
//  AppDelegate.swift
//  TabBarSample
//
//  Created by Roger Yee on 5/21/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         * 1. 创建若干子视图控制器
         * 2. 将创建的子视图控制器添加到数组中
         * 3. 穿件UITabBarController实例
         */
        var firstVC = FirstViewController()
        var firstItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 1)
        firstVC.tabBarItem = firstItem
        firstVC.tabBarItem.badgeValue = "New"
        
        var secondVC = SecondViewController()
        var secondItem = UITabBarItem(title: "消息", image: UIImage(named: "bubble"), tag: 2)
        secondVC.tabBarItem = secondItem
        secondVC.tabBarItem.badgeValue = "2"
        
        var thirdVC = ThirdViewController()
        var thirdItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.History, tag: 1)
        thirdVC.tabBarItem = thirdItem
        
        var forthVC = ForthViewController()
        var forthItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Search, tag: 1)
        forthVC.tabBarItem = forthItem
        
        var views = [firstVC, secondVC, thirdVC, forthVC]
        
        var tabBarController = TabBarViewController()
        tabBarController.setViewControllers(views, animated: true)
        
        self.window?.rootViewController = tabBarController
        
        return true
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

