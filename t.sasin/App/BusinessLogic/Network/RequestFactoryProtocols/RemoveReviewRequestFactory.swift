//
//  RemoveReviewRequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

/**
 * Interface which must be implemented by class that sending request on server that remove review for product
 */
import Alamofire

protocol RemoveReviewRequestFactory {
    
    func removeReview(
        id: Int,
        completionHandler: @escaping (DataResponse<RemoveReviewResult>) -> Void)
}
