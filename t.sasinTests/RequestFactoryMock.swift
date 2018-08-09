//
//  RequestFactoryMock.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    {
        return error
    }
}

class RequestFactoryMock {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParserStub()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        OHHTTPStubs.isEnabled(for: configuration)
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeDeauthRequestFactory() -> DeauthRequestFactory {
        let errorParser = makeErrorParser()
        return Deauth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeRegistrRequestFactory() -> RegistrRequestFactory {
        let errorParser = makeErrorParser()
        return Registr(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeChangePersDataRequestFactory() -> ChangePersDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangePersData(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeSingleProductRequestFactory() -> SingleProductRequestFactory {
        let errorParser = makeErrorParser()
        return SingleProduct(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeCatalogRequestFactory() -> CatalogRequestFactory {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddReview(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeRemoveReviewRequestFactory() -> RemoveReviewRequestFactory {
        let errorParser = makeErrorParser()
        return RemoveReview(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeApproveReviewRequestFactory() -> ApproveReviewRequestFactory {
        let errorParser = makeErrorParser()
        return ApproveReview(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParser = makeErrorParser()
        return AddToBasket(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteFromBasket(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeGetBasketRequestFactory() -> GetBasketRequestFactory {
        let errorParser = makeErrorParser()
        return GetBasket(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
}

