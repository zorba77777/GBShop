//
//  AddReview.swift
//  t.sasin
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request to add review about product on server using alamofire instruments.
 */
import Alamofire

class AddReview: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .addReview
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

extension AddReview: AddReviewRequestFactory {
    
    func addReview(
        id: Int,
        text: String,
        completionHandler: @escaping
        (DataResponse<AddReviewResult>) -> Void
        )
    {
        let requestModel = AddReview(
            baseUrl: urlBuilder.baseUrl,
            path: urlBuilder.path,
            id: id,
            text: text
        )
        self.request(
            reques: requestModel,
            completionHandler: completionHandler
        )
    }
}

extension AddReview {
    
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": id,
                "text": text
            ]
        }
    }
}

