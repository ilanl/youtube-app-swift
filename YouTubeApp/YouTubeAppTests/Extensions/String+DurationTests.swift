//
//  String+DurationTests.swift
//  YouTubeAppTests
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import XCTest
@testable import YouTubeApp

class String_DurationTests: XCTestCase {
    
    func test_hour_min_sec_parsed_to_3_parts() {
        
        let target: String = "PT1H25M9S"
        let durationTitle = target.parseVideoDuration()
        XCTAssertEqual(durationTitle, "01:25:09")
    }
    
    func test_min_sec_parsed_to_2_parts() {
        
        let target: String = "PT25M9S"
        let durationTitle = target.parseVideoDuration()
        XCTAssertEqual(durationTitle, "25:09")
    }
    
    func test_sec_parsed_to_2_parts_with_zero_padding() {
        
        let target: String = "PT9S"
        let durationTitle = target.parseVideoDuration()
        XCTAssertEqual(durationTitle, "00:09")
    }
}
