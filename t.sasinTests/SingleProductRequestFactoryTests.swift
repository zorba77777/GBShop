//
//  SingleProductRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class SingleProductRequestFactoryTests: XCTestCase {
    
    var product: SingleProductRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        product = factory.makeSingleProductRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        product = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testSingleProduct() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("getGoodById.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "getGoodById", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: SingleProductResult?
        product.getSingleProduct(
            idProduct: 1
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
}
