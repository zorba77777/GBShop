//
//  ApproveReview.swift
//  t.sasin
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Class to create and send request to approve review about product on server using alamofire instruments.
 */
import Alamofire

class ApproveReview: AbstractRequestFatory {
    
    let urlBuilder: RequestUrlBuilder = .approveReview
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

extension ApproveReview: ApproveReviewRequestFactory {
    
    func approveReview(
        id: Int,
        completionHandler: @escaping
        (DataResponse<ApproveReviewResult>) -> Void
        )
    {
        let requestModel = ApproveReview(
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

extension ApproveReview {
    
    struct ApproveReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        let id: Int
        var parameters: Parameters? {
            return [
                "id_comment": id
            ]
        }
    }
}
