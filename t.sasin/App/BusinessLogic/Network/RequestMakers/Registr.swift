//
//  Registr.swift
//  t.sasin
//
//  Created by Timur Sasin on 06/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send registration request on server using alamofire instruments.
 */
import Alamofire

class Registr: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .register
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

extension Registr: RegistrRequestFactory {
    
    func register(
        registerDTO: RegisterDTO,
        completionHandler: @escaping (DataResponse<RegistrResult>) -> Void
        )
    {
        let requestModel = Registr(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            registerDTO: registerDTO
            )
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Registr {
    
    struct Registr: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let registerDTO: RegisterDTO
        var parameters: Parameters? {
            return [
                "id_user": registerDTO.id,
                "username": registerDTO.username,
                "password": registerDTO.password,
                "email": registerDTO.email,
                "gender": registerDTO.gender,
                "credit_card": registerDTO.creditCard,
                "bio": registerDTO.bio
            ]
        }
    }
}

