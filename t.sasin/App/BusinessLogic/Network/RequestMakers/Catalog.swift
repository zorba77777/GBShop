//
//  Catalog.swift
//  t.sasin
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request on server to get data for user catalog using alamofire instruments.
 */
import Alamofire

class Catalog: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .catalog
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

extension Catalog: CatalogRequestFactory {
    
    func getCatalog(
        pageNumber: Int,
        idCategory: Int,
        completionHandler: @escaping (DataResponse<[CatalogResult]>) -> Void)
    {
        let requestModel = Catalog(baseUrl: urlBuilder.baseUrl, path: urlBuilder.path, pageNumber: pageNumber, idCategory: idCategory)
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Catalog {
    
    struct Catalog: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let pageNumber: Int
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": idCategory
            ]
        }
    }
}
