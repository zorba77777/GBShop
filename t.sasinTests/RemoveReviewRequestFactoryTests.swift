//
//  RemoveReviewRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 16/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import XCTest

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class RemoveReviewRequestFactoryTests: XCTestCase {
    
    var removeReview: RemoveReviewRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        removeReview = factory.makeRemoveReviewRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        removeReview = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testRemoveReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("removeReview.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "removeReview", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: RemoveReviewResult?
        removeReview.removeReview(
            id: 123
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
