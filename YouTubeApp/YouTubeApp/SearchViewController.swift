//
//  ViewController.swift
//  YouTubeApp
//
//  Created by IlanL on 15/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, PlayerObserverProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var compositePlayer: CompositePlayer!
    
    var searchResults: [VideoInfo] = []
    var fetcherService: SearchEngineProtocol = SearchEngine()
    
    var isSearchBarActive: Bool? {
        didSet {
            if isSearchBarActive != nil && !isSearchBarActive!  {
                searchBar.resignFirstResponder()
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "VideoInfoCell", bundle: nil), forCellReuseIdentifier: "VideoInfoCell")
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.isAccessibilityElement = true
        searchBar.accessibilityIdentifier = "Search.Navigation.SearchBar"
        searchBar.placeholder = "SEARCH VIDEOS"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doSearch(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        self.fetcherService.find(with: searchText) { (results, error) in
            
            DispatchQueue.main.async { [weak self] in
                guard let _self = self else {
                    assertionFailure("nil reference")
                    return
                }
                
                _self.searchResults = results
                _self.tableView.reloadData()
            }
        }
    }
    
    func loadVideo(for video: VideoInfo) {
        self.compositePlayer.observer = self
        self.compositePlayer.openPlayer(for: video)
    }
    
    // MARK: Player Events
    
    func didChangeToReady() {
        self.compositePlayer.isHidden = false //TODO: Add animation In
    }
    
    func didStop() {
        self.compositePlayer.observer = nil
        self.compositePlayer.isHidden = true //TODO: Add Animation Out
    }
}

// MARK: Table View

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoInfoCell", for: indexPath) as! VideoInfoCell
        cell.videoInfo = self.searchResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.isSearchBarActive = false
        let cell = tableView.cellForRow(at: indexPath) as! VideoInfoCell
        self.loadVideo(for: cell.videoInfo)
    }
}

// MARK: Search Bar

extension SearchViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearchBarActive = true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.isSearchBarActive = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchBarActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchBarActive = false
        self.doSearch(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.contains(" ") {
            self.doSearch(searchBar)
        }
    }
}

