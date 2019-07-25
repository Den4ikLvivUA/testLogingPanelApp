//
//  ViewController.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 22.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    
    
    // MARK : - Variables
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    weak var delegate: UsersDelegate?
    
    
    // MARK : - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.layer.cornerRadius = 10.0
    }

    // MARK : - Func Actions for Elements
    
    @IBAction func loginButtonTouched(_ sender: Any) {
        print("Login button touched!")
        
        DispatchQueue.main.async {
            PersistenceManager.shared.changeLoggedStatus(status: PersistenceManager.shared.checkAuth(login: self.numberField.text!, password: self.passwordField.text!), login: self.numberField.text!)
            print(PersistenceManager.shared.checkLogin())
        }
        if PersistenceManager.shared.checkLogin() {
            performSegue(withIdentifier: "userVC", sender: nil)
        }        
    }
    
    //Value in login field changed!
    @IBAction func endEditLogin(_ sender: Any) {
        print("changedValue login field!")
        if numberField.text!.count > 7 && passwordField.text!.count > 3 {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .init(red: 77, green: 160, blue: 246, alpha: 1.0)
        }
    }
    
    
    //Value in password field changed!
    @IBAction func changedValuePasswordField(_ sender: Any) {
        print("changedValue password field!")
        if numberField.text!.count > 7 && passwordField.text!.count > 3 {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .init(red: 77, green: 160, blue: 246, alpha: 1.0)
            
        }
    }
}

