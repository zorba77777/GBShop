//
//  AbstractRequestFatory.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
protocol AbstractRequestFatory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    @discardableResult
    func request<T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> DataRequest
}
extension AbstractRequestFatory {
    @discardableResult
    public func request<T: Decodable>(
        reques: URLRequestConvertible,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> DataRequest {
            return sessionManager
                .request(reques)
                .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
}
