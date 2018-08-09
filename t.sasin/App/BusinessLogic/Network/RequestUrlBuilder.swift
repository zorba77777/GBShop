//
//  RequestUrlBuilder.swift
//  t.sasin
//
//  Created by Timur Sasin on 15/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Enumeration which contains all url addresses using in project to make requests on server
 */
import Foundation

enum RequestUrlBuilder: String {
    
    case auth = "login.json"
    case deauth = "logout.json"
    case register = "registerUser.json"
    case changePersData = "changeUserData.json"
    case singleProduct = "getGoodById.json"
    case catalog = "catalogData.json"
    case addReview = "addReview.json"
    case approveReview = "approveReview.json"
    case removeReview = "removeReview.json"
    case addToBasket = "addToBasket.json"
    case deleteFromBasket = "deleteFromBasket.json"
    case getBasket = "getBasket.json"
    
    var baseUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    }
    
    var path: String {
        return rawValue
    }
}

