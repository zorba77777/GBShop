//
//  AddToBasket.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request to add product to user's basket using alamofire instruments.
 */
import Alamofire

class AddToBasket: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .addToBasket
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension AddToBasket: AddToBasketRequestFactory {
    
    func addToBasket(
        id: Int,
        quantity: Int,
        completionHandler: @escaping
        (DataResponse<AddToBasketResult>) -> Void
        )
    {
        let requestModel = AddToBasket(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            id: id,
            quantity: quantity
        )
        self.request(
            reques: requestModel,
            completionHandler: completionHandler
        )
    }
}

extension AddToBasket {
    
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "id_product": id,
                "quntity": quantity
            ]
        }
    }
}

