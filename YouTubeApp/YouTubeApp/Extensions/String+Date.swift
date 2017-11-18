//
//  String+Duration.swift
//  YouTubeApp
//
//  Created by IlanL on 17/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localDate = formatter.date(from: self)!
        return localDate
    }
}
