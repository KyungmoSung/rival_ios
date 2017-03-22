//
//  AppDelegate.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 7..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    
    var deviceToken: Data? = nil
    
    fileprivate func setupEntryController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let navigationController2 = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
        navigationController.pushViewController(viewController, animated: true)
        self.loginViewController = navigationController
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
        navigationController2.pushViewController(viewController2, animated: true)
        self.mainViewController = navigationController2
    }
    
    fileprivate func reloadRootViewController() {
        let isOpened = KOSession.shared().isOpen()
        if !isOpened {
            let mainViewController = self.mainViewController as! UINavigationController
            
            let stack = mainViewController.viewControllers
            for i in 0 ..< stack.count {
                print(NSString(format: "[%d]: %@", i, stack[i] as UIViewController))
            }
            mainViewController.popToRootViewController(animated: true)
        }
        
        self.window?.rootViewController = isOpened ? self.mainViewController : self.loginViewController
        self.window?.makeKeyAndVisible()
    }
    
    fileprivate func setTableViewSelectedBackgroundViewColor() {
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red: 0xff / 255.0, green:  0xcc / 255.0, blue:  0x00 / 255.0, alpha: 1.0)
        UITableViewCell.appearance().selectedBackgroundView = colorView
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 최초 실행시 2 종류의 rootViewController 를 준비한다.
        setupEntryController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.kakaoSessionDidChangeWithNotification), name: NSNotification.Name.KOSessionDidChange, object: nil)
        
        reloadRootViewController()
        setTableViewSelectedBackgroundViewColor()
        
        // notification
        if #available(iOS 8.0, *) {
            let types: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: types, categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            application.registerForRemoteNotifications(matching: [UIRemoteNotificationType.badge, UIRemoteNotificationType.sound, UIRemoteNotificationType.alert])
        }
        
        let session = KOSession.shared()
        session?.presentedViewBarTintColor = UIColor(red: 0x2a / 255.0, green: 0x2a / 255.0, blue: 0x2a / 255.0, alpha: 1.0)
        session?.presentedViewBarButtonTintColor = UIColor(red: 0xe5 / 255.0, green: 0xe5 / 255.0, blue: 0xe5 / 255.0, alpha: 1.0)
        
        return true
    }
    
    func kakaoSessionDidChangeWithNotification() {
        reloadRootViewController()
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        KOSession.handleDidEnterBackground()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        KOSession.handleDidBecomeActive()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let dic = userInfo["aps"] as? NSDictionary {
            let message: String = dic["alert"] as! String
            print("message=\(message)")
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
        print("didRegisterForRemoteNotificationsWithDeviceToken=\(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError=\(error.localizedDescription)")
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        //MapleBaconStorage.sharedStorage.clearMemoryStorage()
    }
}
