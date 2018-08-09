//
//  DeleteFromBasketResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a request to delete a product selected by user from a basket.
 */
struct DeleteFromBasketResult: Codable {
    let result: Int
}

