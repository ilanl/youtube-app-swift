//
//  YouTubeAppTests.swift
//  YouTubeAppTests
//
//  Created by IlanL on 15/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import XCTest
@testable import YouTubeApp

class SearchEngineTests: XCTestCase {
    
    var target: SearchEngine!
    
    override func setUp() {
        super.setUp()
        self.target = SearchEngine()
    }
    
    override func tearDown() {
        super.tearDown()
        self.target = nil
    }
    
    func test_search_success() {
        
        let expectToFetchVideo = expectation(description: "to retrieve video results")
        
        self.target.find(with: "arduino") { (results, error) in
            print(results)
            if results.count > 0 {
                expectToFetchVideo.fulfill()
            }
        }
        
        wait(for: [expectToFetchVideo], timeout: 5)
    }
    
    func test_search_fails_when_empty_input() {
        
        let expectInvalidParameters = expectation(description: "to fail with invalid params")
        
        target.find(with: "") { (results, error) in
            if error == ErrorType.invalidParameters {
                expectInvalidParameters.fulfill()
            }
        }
        
        wait(for: [expectInvalidParameters], timeout: 5)
    }
}
