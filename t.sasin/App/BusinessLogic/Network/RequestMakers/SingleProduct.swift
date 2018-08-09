//
//  SingleProduct.swift
//  t.sasin
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request on server to get data for single product using alamofire instruments.
 */
import Alamofire

class SingleProduct: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .singleProduct
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

extension SingleProduct: SingleProductRequestFactory {
    
    func getSingleProduct(idProduct: Int,
                          completionHandler: @escaping (DataResponse<SingleProductResult>) -> Void)
    {
        let requestModel = SingleProduct(baseUrl: urlBuilder.baseUrl, path: urlBuilder.path, idProduct: idProduct)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
}

extension SingleProduct {
    
    struct SingleProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct
            ]
        }
    }
}
