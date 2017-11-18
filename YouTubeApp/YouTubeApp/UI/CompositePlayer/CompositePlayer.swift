//
//  CompositePlayer.swift
//  YouTubeApp
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class CompositePlayer: UIView, YTPlayerViewDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var player: YTPlayerView!
    weak var observer: PlayerObserverProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    @IBAction func didPressClose(_ sender: UIButton) {
        self.player.stopVideo()
        self.observer!.didStop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        let contentView = Bundle.main.loadNibNamed("CompositePlayer", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)
        self.player.delegate = self
    }
    
    func openPlayer(for video: VideoInfo) {
        self.closeButton.isHidden = false
        let playerVars = ["playsinline": 1, "autoplay": 1, "autohide": 1, "controls" : 1, "showinfo" : 0, "modestbranding" : 1, "rel" : 0]
        self.player.load(withVideoId: video.id, playerVars: playerVars)
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.player.playVideo()
        self.player.isHidden = false
        self.observer!.didChangeToReady()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        print("state: \(state)")
    }
}
