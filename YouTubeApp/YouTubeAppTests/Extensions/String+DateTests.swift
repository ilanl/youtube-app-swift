//
//  String+DateTests.swift
//  YouTubeAppTests
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import XCTest
@testable import YouTubeApp

class String_DateTests: XCTestCase {
    
    func test_date_is_correctly_formatted() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateStr = dateFormatter.string(from: date)
        
        let newDate = dateStr.toDate()!
        XCTAssertEqual(newDate.timeIntervalSince1970.rounded(.towardZero), date.timeIntervalSince1970.rounded(.towardZero))
    }
}
