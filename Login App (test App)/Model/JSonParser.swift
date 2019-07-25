//
//  JSonParser.swift
//  Login App (test App)
//
//  Created by Den4ikLvivUA on 22.07.2019.
//  Copyright © 2019 Den4ikLvivUA. All rights reserved.
//

import UIKit
import Foundation


//MARK :- Structs for JSONParsing

struct dataStruct: Decodable {
    var data: userStruct?
}
struct userStruct: Decodable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}


//MARK :- EXAMPLE OF JSON ANSWER

/*
 {
 "data":{
 "id":2,
 "email":"janet.weaver@reqres.in",
 "first_name":"Janet",
 "last_name": "Weaver",
 "avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"
 }
 }
 */
