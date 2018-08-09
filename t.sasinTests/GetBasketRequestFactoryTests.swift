//
//  GetBasketRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class GetBasketRequestFactoryTests: XCTestCase {
    
    var getBasket: GetBasketRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        getBasket = factory.makeGetBasketRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        getBasket = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("getBasket.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "getBasket", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: GetBasketResult?
        getBasket.getBasket(
            id: 123
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
