//
//  SearchEngine.swift
//  YouTubeApp
//
//  Created by IlanL on 15/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ErrorType: Error {
    case invalidParameters
}

protocol SearchEngineProtocol : class {
    
    func find(with text: String, completion: @escaping ((_ results: [VideoInfo], _ error: ErrorType?)->Void))
}

class SearchEngine: SearchEngineProtocol {
    
    private static let API_KEY = Bundle.main.object(forInfoDictionaryKey: "GoogleSecretKey") as! String
    private static let MAX_RESULTS = 10
    
    func find(with text: String, completion: @escaping (([VideoInfo], ErrorType?) -> Void)) {
        
        guard !text.isEmpty else {
            completion([], ErrorType.invalidParameters)
            return
        }
        
        let strURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=\(SearchEngine.MAX_RESULTS)&order=relevance&q=\(text)&type=video&key=\(SearchEngine.API_KEY)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let queue = DispatchQueue(label: "com.YouTubeApp.API", qos: .background, attributes: .concurrent)
        Alamofire.request(strURL, method: .get).validate(contentType: ["application/json"]).responseJSON(queue: queue) { [weak self] response in

            guard let data = response.data else {
                completion([], ErrorType.invalidParameters)
                return
            }
            
            let json = JSON(data: data)
            
            let snippets = json["items"].map({ (str, item) -> VideoSnippet in

                let id = item["id"]["videoId"].string!
                let snippet = item["snippet"]
                let title = snippet["title"].string!
                let imageUrl = snippet["thumbnails"]["default"]["url"].string!
                let publishedAt = snippet["publishedAt"].string!
                let channelTitle = snippet["channelTitle"].string!

                return VideoSnippet(id: id, title: title, imageUrl: imageUrl, publishedAt: publishedAt, channelTitle: channelTitle)
            })

            // Bulk-search for content details
            
            let ids = snippets.map({ $0.id }).joined(separator: ",")
            let strContentURL = "https://www.googleapis.com/youtube/v3/videos?id=\(ids)&part=contentDetails&key=\(SearchEngine.API_KEY)"

            Alamofire.request(strContentURL, method: .get).validate(contentType: ["application/json"]).responseJSON { response in
                
                guard let data = response.data else {
                    completion([], ErrorType.invalidParameters)
                    return
                }
                
                let json = JSON(data: data)
                
                let details = json["items"].map({ (str, item) -> VideoDetails in
                    
                    let contentDetails = item["contentDetails"]
                    let duration = contentDetails["duration"].string!
                    return VideoDetails(duration: duration)
                })
                
                var results: [VideoInfo] = []
                
                if snippets.count > 0 {
                    for i in 0...snippets.count-1 {
                        let snippet = snippets[i]
                        let detail = details[i]
                        results.append(VideoInfo(imageUrl: snippet.imageUrl, id: snippet.id, title: snippet.title, publishedDate: snippet.publishedAt.toDate()!, durationTitle: detail.duration.parseVideoDuration(), channelTitle: snippet.channelTitle))
                    }
                }
                
                completion(results, nil)
            }
        }
    }
}
