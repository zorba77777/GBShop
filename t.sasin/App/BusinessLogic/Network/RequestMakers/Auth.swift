//
//  Auth.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send authorization request on server using alamofire instruments.
 */
import Alamofire

class Auth: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .auth
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

extension Auth: AuthRequestFactory {
    
    func login(
        userName: String,
        password: String,
        completionHandler: @escaping
        (DataResponse<LoginResult>) -> Void
        )
    {
        let requestModel = Login(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            login: userName,
            password: password
        )
        self.request(
            reques: requestModel,
            completionHandler: completionHandler
        )
    }
}

extension Auth {
    
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}
