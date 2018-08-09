//
//  GetBasket.swift
//  t.sasin
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request to get content of basket using alamofire instruments.
 */
import Alamofire

class GetBasket: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .getBasket
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

extension GetBasket: GetBasketRequestFactory {
    
    func getBasket(
        id: Int,
        completionHandler: @escaping
        (DataResponse<GetBasketResult>) -> Void
        )
    {
        let requestModel = GetBasket(
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

extension GetBasket {
    
    struct GetBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: Int
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
}
