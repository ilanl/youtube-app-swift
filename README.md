# App

This app aims to search videos from YouTube

Type in the search bar on top and then click keyboard 'Search' key, it will retrieve top 10 results ordered by relevance brought by YouTube API.

We'll use 2 YouTube APIs: 
* 'search' to provide high-level data from part=snippet
* 'videos' to provide more detailed properties from part=contentDetails

Each cell shows:

  - Title
  - Duration
  - Channel Title
  - Published Date
  - Thumbnail

# High Level

## UI 

We have only 2 screens:
* A list with search functionality
* A player with standart functions

### Search Engine

Responsible to retrieve results from YouTube API. Using API Key
See 'GoogleSecretKey' in .plist

It will make a first request to get snippet data and run another bulk request for all the retrieved videoIds at once and get the contentDetails.

Then with snippet and content combined, we'll return VideoInfo to the UI

# Installation

Some requirements:

XCode 9, Swift 3.2

We are using 3 Pod dependencies:
* Alamofire v4.5
* SwiftyJSON v3.1.4
* youtube-ios-player-helper v0.1

Install the dependencies:
$ pod install
