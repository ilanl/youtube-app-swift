//
//  UIImageView+URLTests.swift
//  YouTubeAppTests
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import XCTest
import UIKit
@testable import YouTubeApp

class UIImageView_URLTests: XCTestCase {
    
    func test_image_loaded_async() {
        let imageView: UIImageView = UIImageView()
        let expectImageLoaded = expectation(description: "to load image and hide activity")
        
        imageView.loadImage(urlString: "https://cdn.eso.org/images/screen/eso9925a.jpg", completion: { state in
            guard state == true else { return }
            if imageView.subviews.count == 0 {
                if imageView.image?.cgImage != nil {
                    expectImageLoaded.fulfill()
                }
            }
        })
        wait(for: [expectImageLoaded], timeout: 10)
    }
}
