//
//  Date+FriendlyTests.swift
//  YouTubeAppTests
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import XCTest
@testable import YouTubeApp

class Date_SinceTests: XCTestCase {
    
    func test_success_3_days() {
        
        let target = Date().addingTimeInterval(-1 * 60 * 60 * 24 * 3)
        XCTAssertEqual("3 days ago", target.since)
    }
    
    func test_success_5_hours() {
        
        let target = Date().addingTimeInterval(-18020)
        XCTAssertEqual("5 hours ago", target.since)
    }
    
    func test_success_1_min() {
        
        let target = Date().addingTimeInterval(-1 * 80)
        XCTAssertEqual("1 min ago", target.since)
    }
}

