//
//  AuthRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending authorisation request on server
 */
import Alamofire

protocol AuthRequestFactory {
    
    func login(
        userName: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>) -> Void
    )
}
