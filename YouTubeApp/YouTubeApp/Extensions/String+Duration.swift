//
//  String+Duration.swift
//  YouTubeApp
//
//  Created by IlanL on 17/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation

extension String{
    
    func parseVideoDuration() -> String {
        
        let formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        
        let components = formattedDuration.components(separatedBy: ":")
        var duration = ""
        for component in components {
            duration = duration.characters.count > 0 ? duration + ":" : duration
            if component.characters.count < 2 {
                duration += "0" + component
                continue
            }
            duration += component
        }
        
        if duration.count == 2 {
            duration = "00:\(duration)"
        }
        
        return duration
    }
}


