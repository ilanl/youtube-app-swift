//
//  UIImageView.swift
//  YouTubeApp
//
//  Created by IlanL on 17/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func loadImage(urlString: String, completion: ((_ state: Bool)->Void)? = nil) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                completion?(false)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
                
                completion?(true)
            })
            
        }).resume()
    }
}
