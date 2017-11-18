//
//  VideoInfo.swift
//  YouTubeApp
//
//  Created by IlanL on 15/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation

/*
 ## Requirements ##
 
 • VideoImage (thumbnails)
 • Title
 • VideoDuration
 • PlaylistTitle / I guess you meant Channel Title ? Need to check with @Dror
 • PublishedDate
 
 */

struct VideoInfo {
    
    // Image
    var imageUrl: String
    
    // Id
    var id: String
    
    // Title
    var title: String
    
    // PublishedDate
    var publishedDate: Date
    
    // Duration in secs
    var durationTitle: String
    
    // Channel Title
    var channelTitle: String
    
}

