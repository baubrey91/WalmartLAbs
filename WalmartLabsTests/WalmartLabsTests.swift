//
//  WalmartLabsTests.swift
//  WalmartLabsTests
//
//  Created by Brandon on 9/1/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import XCTest
@testable import WalmartLabs

class WalmartLabsTests: XCTestCase {
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testValidStatusCode() {
        guard let productURL = Client.sharedInstance.getProductURL(pageNumber: 1, pageSize: 10)
            else {
                XCTFail("invalid URL")
                return
        }
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: productURL) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func callToWalmart() {
        guard let productURL = Client.sharedInstance.getProductURL(pageNumber: 1, pageSize: 10)
            else {
                XCTFail("invalid URL")
                return
        }
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: productURL) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
