//
//  LoginResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a login request.
 */
struct LoginResult: Codable {
    let result: Int
    let user: User
    
    struct User: Codable {
        let id: Int
        let login: String
        let name: String
        let lastname: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id_user"
            case login = "user_login"
            case name = "user_name"
            case lastname = "user_lastname"
        }
    }
}
