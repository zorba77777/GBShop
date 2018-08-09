//
//  ApproveReviewRequestFactoryTests.swift
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

class ApproveReviewRequestFactoryTests: XCTestCase {
    
    var approveReview: ApproveReviewRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        approveReview = factory.makeApproveReviewRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        approveReview = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testApproveReview() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("approveReview.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "approveReview", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: ApproveReviewResult?
        approveReview.approveReview(
            id: 123
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
