//
//  DeleteFromBasket.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request to delete product from user's basket using alamofire instruments.
 */
import Alamofire

class DeleteFromBasket: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .deleteFromBasket
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

extension DeleteFromBasket: DeleteFromBasketRequestFactory {
    
    func deleteFromBasket(
        id: Int,
        completionHandler: @escaping
        (DataResponse<DeleteFromBasketResult>) -> Void
        )
    {
        let requestModel = DeleteFromBasket(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            id: id
        )
        self.request(
            reques: requestModel,
            completionHandler: completionHandler
        )
    }
}

extension DeleteFromBasket {
    
    struct DeleteFromBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: Int
        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }
    }
}
