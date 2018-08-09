//
//  DeauthRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class DeauthRequestFactoryTests: XCTestCase {
    
    var deauth: DeauthRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        deauth = factory.makeDeauthRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        deauth = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testDeauth() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("logout.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "logout", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: LogoutResult?
        deauth.logout(
            id: "123"
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
}
