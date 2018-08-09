//
//  AddReviewResult.swift
//  t.sasin
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a request to add review for product.
 */
struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String
}
