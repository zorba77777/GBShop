//
//  ResponseCodableTests.swift
//  t.sasinTests
//
//  Created by Timur Sasin on 08/07/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//
import Alamofire
import XCTest
@testable import t_sasin

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}



class ResponseCodableTests: XCTestCase {
    
    var errorParser: ErrorParserStub!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        
        let exp = expectation(description: "")
        
        var post: PostStub?
        Alamofire
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub>) in
                post = response.value
                exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(post)
    }
    
    func testShouldBeFailParse() {
        
        let exp = expectation(description: "")
        
        var post: PostStub?
        Alamofire
            .request("https://fake.ru")
            .responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub>) in
                post = response.value
                exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertNil(post)
    }
    
}
