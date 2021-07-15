//
//  RedditLiteTests.swift
//  RedditLiteTests
//
//  Created by Alana Santos on 12/07/21.
//

import XCTest
@testable import RedditLite

class RedditLiteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetEntriesServiceSuccess() throws {
        let expectation = self.expectation(description: "getEntries")
        var testResult: EntryResponseData? = nil
        
        EntryService().getEntries(handler: ServiceHandler(success: { response in
            testResult = response
            expectation.fulfill()
        }, error: { error in
            expectation.fulfill()
        }))
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(testResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
