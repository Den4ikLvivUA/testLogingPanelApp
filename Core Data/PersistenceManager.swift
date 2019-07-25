//
//  PersistanceManager.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 25.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class PersistenceManager {
    
    private init() {}
    static var shared = PersistenceManager()
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Login_App__test_App_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    lazy var context = persistentContainer.viewContext
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED!")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loginChecked() {
        if (checkLogin()){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "UserVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    //******************************
    //******************************
    // MARK :- Function for CoreData
    //******************************
    //******************************
    
    func changeLoggedStatus(status: Bool, login: String) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let userObject = NSManagedObject(entity: entity!, insertInto: context) as! User
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        userObject.isLogged = status
        save()
        print("status changed!")
    }
    
    func checkLogin() -> Bool {
        var user: [User]
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "isLogged == %i", true)
        do {
            user = try context.fetch(fetchRequest)
            print("USERS matched = \(user.count)")
            if user.count > 0 {
                return true
            }
        } catch {
            print(error.localizedDescription)
            
        }
        return false
    }
    
    func addNewUser(login: String, password: String){
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let userObject = NSManagedObject(entity: entity!, insertInto: context) as! User
        userObject.login = login
        userObject.password = password
        save()
        print("USER ADDED!")
    }
    
    func checkAuth(login: String, password: String) -> Bool {
        var user: [User]
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
        do {
            user = try context.fetch(fetchRequest)
            print("USERS matched = \(user.count)")
            if user.count > 0 {
                return true
            }
        } catch {
            print(error.localizedDescription)
            
        }
        return false
    }
    
    func printUsers() {
        guard let users = try! context.fetch(User.fetchRequest()) as? [User]
            else { return }
        users.forEach({ print("Login is \(String(describing: $0.login)) and password is \(String(describing: $0.password)) and ID is \($0.id)")})
        
    }
    
    
    func deleteUser() {
        var user: User
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }
        user = NSManagedObject(entity: entity, insertInto: context) as! User
        
        context.delete(user)
    }
    //******************************
    //******************************
    //MARK :- END OF COREDATA METHODS
    //******************************
    //******************************
}
