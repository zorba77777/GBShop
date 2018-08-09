//
//  AddReviewRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class AddReviewRequestFactoryTests: XCTestCase {
    
    var addReview: AddReviewRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        addReview = factory.makeAddReviewRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        addReview = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("addReview.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "addReview", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: AddReviewResult?
        addReview.addReview(
            id: 123,
            text: "abc"
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
}

