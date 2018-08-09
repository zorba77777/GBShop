//
//  CatalogRequestFactoryTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 09/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Alamofire
import XCTest
import OHHTTPStubs
@testable import t_sasin

class CatalogRequestFactoryTests: XCTestCase {
    
    var catalog: CatalogRequestFactory!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        catalog = factory.makeCatalogRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        catalog = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testCatalog() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("catalogData.json")) { request in
            let fileUrl = Bundle.main.url(forResource: "catalogData", withExtension: "json")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
        
        var user: Array<CatalogResult>?
        catalog.getCatalog(
            pageNumber: 1,
            idCategory: 1
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
}
