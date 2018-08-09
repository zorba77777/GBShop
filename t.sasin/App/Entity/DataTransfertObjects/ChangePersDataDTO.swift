//
//  ChangePersDataDTO.swift
//  t.sasin
//
//  Created by Timur Sasin on 15/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to facilitate data transfer to make change personal data request. It is used in ChangePersData.swift
 */
struct ChangePersDataDTO {
    let id: String
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
