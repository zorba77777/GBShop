//
//  SingleProductResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a request to get single product by id.
 */
struct SingleProductResult: Codable {
    let result: Int
    let product_name: String
    let product_price: Int
    let product_description: String
}
