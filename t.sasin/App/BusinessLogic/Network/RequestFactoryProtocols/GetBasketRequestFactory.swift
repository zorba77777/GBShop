//
//  GetBasketRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server to get user's basket content
 */
import Alamofire

protocol GetBasketRequestFactory {
    
    func getBasket(
        id: Int,
        completionHandler: @escaping (DataResponse<GetBasketResult>) -> Void)
}
