//
//  AddToBasketResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a request to add a product selected by user to a basket.
 */
struct AddToBasketResult: Codable {
    let result: Int
}
