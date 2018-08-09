//
//  DeleteFromBasketRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server to delete product from user's basket
 */
import Alamofire

protocol DeleteFromBasketRequestFactory {
    
    func deleteFromBasket(
        id: Int,
        completionHandler: @escaping (DataResponse<DeleteFromBasketResult>) -> Void)
}

