//
//  RegisterDTO.swift
//  t.sasin
//
//  Created by Timur Sasin on 15/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to facilitate data transfer to make register request. It is used in Registr.swift
 */
struct RegisterDTO {
    let id: String
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
