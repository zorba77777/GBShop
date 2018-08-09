//
//  AddToBasketRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class AddToBasketRequestFactoryTests: XCTestCase {
    
    var addToBasket: AddToBasketRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        addToBasket = factory.makeAddToBasketRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        addToBasket = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("addToBasket.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "addToBasket", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: AddToBasketResult?
        addToBasket.addToBasket(
            id: 123,
            quantity: 1
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
