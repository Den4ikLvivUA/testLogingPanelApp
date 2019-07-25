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
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1] as URL)
        if (PersistenceManager.shared.checkLogin()){
            print("Logging isn't required, status of logging - true")}
        else{
            print("Logging is REQUIRED, status of logging - false")
        }
        if (PersistenceManager.shared.checkLogin()){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "UserVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        PersistenceManager.shared.save()
    }
}

