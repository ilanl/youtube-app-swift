//
//  PlayerObserverProtocol.swift
//  YouTubeApp
//
//  Created by IlanL on 18/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation

protocol PlayerObserverProtocol: class {
    func didStop()
    func didChangeToReady()
}

