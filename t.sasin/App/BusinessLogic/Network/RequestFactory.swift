//
//  RequestFactory.swift
//  t.sasin
//
//  Created by Timur Sasin on 05/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
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
