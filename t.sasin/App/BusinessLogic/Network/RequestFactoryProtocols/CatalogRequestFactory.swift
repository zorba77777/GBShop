//
//  CatalogRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server to get single product by its id
 */
import Alamofire

protocol CatalogRequestFactory {
    
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping
        (DataResponse<[CatalogResult]>) -> Void)
}

