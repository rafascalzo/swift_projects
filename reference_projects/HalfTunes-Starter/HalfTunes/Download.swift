//
//  Download.swift
//  HalfTunes
//
//  Created by rafaeldelegate on 6/26/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {
  //track: The track to download. The track’s url property also acts as a unique identifier for a Download.
  var track: Track
  init(track: Track) {
    self.track = track
  }
  
  // Download service sets these values: task: The URLSessionDownloadTask that downloads the track.
  var task: URLSessionDownloadTask?
  //verify if its paused
  var isDownloading = false
  //Stores the Data produced when the user pauses a download task. If the host server supports it, your app can use this to resume a paused download in the future.
  var resumeData: Data?
  
  // Download delegate sets this value: 0 - 1
  var progress: Float = 0
  
}
