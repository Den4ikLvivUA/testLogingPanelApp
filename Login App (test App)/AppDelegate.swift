//
//  AppDelegate.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 22.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1] as URL)
        print("LOGIN IS REQUIRED, status of Logging - \(PersistenceManager.shared.checkLogin())")
        if (PersistenceManager.shared.checkLogin()){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "UserVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    

}

