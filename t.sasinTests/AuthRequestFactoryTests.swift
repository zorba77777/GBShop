//
//  AuthRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class AuthRequestFactoryTests: XCTestCase {
   
    var auth: AuthRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        auth = factory.makeAuthRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        auth = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAuth() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("login.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "login", withExtension: "json")!
            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil
                )
        }
        
        var user: LoginResult?
        auth.login(
            userName: "asdasd",
            password: "asdasd"
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
}
