//
//  AddToBasketRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server to add product to user's basket
 */
import Alamofire

protocol AddToBasketRequestFactory {
    
    func addToBasket(
        id: Int,
        quantity: Int,
        completionHandler: @escaping (DataResponse<AddToBasketResult>) -> Void)
}

