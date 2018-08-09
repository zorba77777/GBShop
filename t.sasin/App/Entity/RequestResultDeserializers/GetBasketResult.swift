//
//  GetBasketResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//


/**
 * Structure to parse json data received from a server as a reply on a request to get user basket content.
 */
struct GetBasketResult: Codable {
    let amount: Int
    let countGoods: Int
    let contents: Array<Item>
    
    struct Item: Codable {
        let id_product: Int
        let product_name: String
        let price: Int
        let quantity: Int
    }
    
}
