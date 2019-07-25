//
//  Protocols and extensions.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 23.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import Foundation
import UIKit

//MARK :- Variables

private let urlString = "https://reqres.in/api/users/2"

//MARK :- Delegate

protocol UsersDelegate : class  {
    func ParsData(completion: @escaping (userStruct?, Error?) ->())
    func push()
}

//MARK :- Extension for delegate's job

extension UserViewController : UsersDelegate{

    func push(){
        let vc = UserViewController()
        vc.delegate = self
    }
    
    func ParsData(completion: @escaping (userStruct?, Error?) ->()) {
        var tempUserStruct: userStruct?
        print("PARSING DATA..")
        let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!){
                (data, response, error) in
                guard let data = data else { print("NO DATA!"); completion(nil, nil); return }
                do{
                    let user = try JSONDecoder().decode(dataStruct.self, from: data)
                    tempUserStruct = userStruct(id: user.data!.id, email: user.data!.email, first_name: user.data!.first_name, last_name: user.data!.last_name, avatar: user.data!.avatar)
                    completion(tempUserStruct, nil)
                    print("LOADED DATA!!!!")                  
                }   catch let error { completion( nil, error) }
                }.resume()
    }
        
}
