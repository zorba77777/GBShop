//
//  RegistrRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class RegistrRequestFactoryTests: XCTestCase {
    
    var registr: RegistrRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        registr = factory.makeRegistrRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        registr = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testRegistr() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("registerUser.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "registerUser", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: RegistrResult?
        registr.register(
            registerDTO: RegisterDTO(id: "123",
                                     username: "Somebody",
                                     password: "mypassword",
                                     email: "some@some.ru",
                                     gender: "m",
                                     creditCard: "9872389-2424-234224-234",
                                     bio: "This is good! I think I will switch to another language")
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
}
