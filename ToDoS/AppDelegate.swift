//
//  AppDelegate.swift
//  ToDoS
//
//  Created by Ciobanasu Ion on 18/05/2018.
//  Copyright © 2018 Laurean Mateiu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .dark
        
      if let status = UIApplication.shared.value(forKey: "statusBar") as? UIView {
        status.backgroundColor = UIColor.init(red: 0.0/255.0, green: 2550/255.0, blue: 0.0/255.0, alpha: 1)
      }
        return true
      }
    
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = self.window!.rootViewController as! UINavigationController
       
        if shortcutItem.type == "add_new_todo"
        {
            let newToDoController: InsertViewController = storyboard.instantiateViewController(withIdentifier: "NewTODO") as! InsertViewController
            rootViewController.pushViewController(newToDoController, animated: true)
        }
        if shortcutItem.type == "view_your_list" {
            let viewListController: ViewController = storyboard.instantiateViewController(withIdentifier: "normal") as! ViewController
            rootViewController.pushViewController(viewListController, animated: true)
        }
    }
}

