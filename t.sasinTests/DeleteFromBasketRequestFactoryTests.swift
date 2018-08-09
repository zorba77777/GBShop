//
//  DeleteFromBasketRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 19/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class DeleteFromBasketRequestFactoryTests: XCTestCase {
    
    var deleteFromBasket: DeleteFromBasketRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        deleteFromBasket = factory.makeDeleteFromBasketRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        deleteFromBasket = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("deleteFromBasket.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "deleteFromBasket", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: DeleteFromBasketResult?
        deleteFromBasket.deleteFromBasket(
            id: 123
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
