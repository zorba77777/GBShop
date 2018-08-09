//
//  Catalog.swift
//  t.sasin
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Structure to parse json data received from a server as a reply on a request to get catalog data.
 */
struct CatalogResult: Codable {
    var id_product: Int
    var product_name: String
    var price: Int
}
