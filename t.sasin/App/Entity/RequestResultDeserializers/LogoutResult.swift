//
//  LogoutResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a logout request.
 */
struct LogoutResult: Codable {
    let result: Int
}
