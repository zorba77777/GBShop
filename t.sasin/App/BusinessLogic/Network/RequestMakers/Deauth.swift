//
//  Deauth.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send deauthorization request on server using alamofire instruments.
 */
import Alamofire

class Deauth: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .deauth
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

extension Deauth: DeauthRequestFactory {
    
    func logout(
        id: String,
        completionHandler: @escaping (DataResponse<LogoutResult>) -> Void)
    {
        let requestModel = Logout(baseUrl: urlBuilder.baseUrl, path: urlBuilder.path, id: id)
        self.request(
            reques: requestModel,
            completionHandler: completionHandler
        )
    }
}

extension Deauth {
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: String
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
}
