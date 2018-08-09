//
//  ChangePersData.swift
//  t.sasin
//
//  Created by Timur Sasin on 06/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request on server to change user data using alamofire instruments.
 */
import Alamofire

class ChangePersData: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .changePersData
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

extension ChangePersData: ChangePersDataRequestFactory {
    
    func changePersData (
        changePersDataDTO: ChangePersDataDTO,
        completionHandler: @escaping (DataResponse<ChangePersDataResult>) -> Void
        )
    {
        let requestModel = ChangePersData(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            changePersDataDTO: changePersDataDTO
        )
        self.request(reques: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension ChangePersData {
    
    struct ChangePersData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let changePersDataDTO: ChangePersDataDTO
        var parameters: Parameters? {
            return [
                "id_user": changePersDataDTO.id,
                "username": changePersDataDTO.username,
                "password": changePersDataDTO.password,
                "email": changePersDataDTO.email,
                "gender": changePersDataDTO.gender,
                "credit_card": changePersDataDTO.creditCard,
                "bio": changePersDataDTO.bio
            ]
        }
    }
}

