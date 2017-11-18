//
//  VideoInfoCell.swift
//  YouTubeApp
//
//  Created by IlanL on 15/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setAccessibility(identifier: String) {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = identifier
    }
}

class VideoInfoCell: UITableViewCell {
    
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var channelAndDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
        //Set accessibility for some elements
        self.setAccessibility(identifier: "VideoInfoCell.cell")
        self.smallImage.setAccessibility(identifier: "VideoInfoCell.image")
        self.title.setAccessibility(identifier: "VideoInfoCell.title")
    }
    
    var videoInfo: VideoInfo! {
        didSet {
            self.refresh()
        }
    }
    
    func refresh() {
        
        self.title.text = self.videoInfo.title
        self.channelAndDateLabel.text = "\(self.videoInfo.channelTitle) - \(self.videoInfo.publishedDate.since)"
        self.smallImage?.loadImage(urlString: self.videoInfo.imageUrl)
        self.durationLabel.text = self.videoInfo.durationTitle.parseVideoDuration()
    }
}
