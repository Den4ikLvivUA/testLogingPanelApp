//
//  UserViewController.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 22.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import UIKit
import CoreData



class UserViewController: UIViewController {
    
    //MARK :- Variables
    
    weak var delegate: UsersDelegate?
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSecondName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = LoginViewController()
        let session = URLSession.shared
        vc.delegate = self
        ParsData( completion: {[weak self] (user, error) in
            guard let user = user else { print("Nil :("); return }
            DispatchQueue.main.async {
                print(user)
                
                self?.userIDLabel.text = "User id:\(String(user.id))"
                self?.userName.text = String(user.first_name)
                self?.userSecondName.text = String(user.last_name)
                self?.userEmail.text = String(user.email)
                guard let url = URL(string: user.avatar) else { print("user.avatar is nil"); return }
                session.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self?.userImage.image = image
                        }
                    }
                    }.resume()
            }
        })
    }
    
    @IBAction func touchedExitButton(_ sender: UIBarButtonItem) {
            guard let users = try!PersistenceManager.shared.context.fetch(User.fetchRequest()) as? [User]
            else { return }
        print(users.count)
        PersistenceManager.shared.save()
        
    }
}




