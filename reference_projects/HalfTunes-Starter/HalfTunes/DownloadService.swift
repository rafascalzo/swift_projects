/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

// Downloads song snippets, and stores in local file.
// Allows cancel, pause, resume download.
class DownloadService {

  // SearchViewController creates downloadsSession
  var downloadsSession: URLSession!
  var activeDownloads: [URL: Download] = [:]

  // MARK: - Download methods called by TrackCell delegate methods

  func startDownload(_ track: Track) {
    // TODO
    // 1 first initialize a Download with the track.
    let download = Download(track: track)
    // 2 Using a new session object, create a URLSessionDownloadTask with the track’s preview URL, and set it to the task property of the Download.
    download.task = downloadsSession.downloadTask(with: track.previewURL)
    // 3 start the download task by calling resume() on it.
    download.task!.resume()
    // 4 indicate that the download is in progress.
    download.isDownloading = true
    // 5 map the download URL to its Download in the activeDownloads dictionary.
    activeDownloads[download.track.previewURL] = download
  }
  // TODO: previewURL is http://a902.phobos.apple.com/...
  // why doesn't ATS prevent this download?

  func pauseDownload(_ track: Track) {
    // TODO
    
//    Pausing a download is conceptually similar to cancelling: pausing cancels the download task, but also produces resume data, which contains enough information to resume the download at a later time, if the host server supports that functionality.
//    Note: You can only resume a download under certain conditions. For instance, the resource must not have changed since you first requested it. For a full list of conditions, check out the documentation
    
    guard let download = activeDownloads[track.previewURL] else { return }
    if download.isDownloading {
      download.task?.cancel(byProducingResumeData: { data in
        download.resumeData = data
      })
      download.isDownloading = false
    }
    
//    The key difference here is you call cancel(byProducingResumeData:) instead of cancel(). You provide a closure parameter to this method, where you save the resume data to the appropriate Download for future resumption.
//      You also set the isDownloading property of the Download to false to indicate that the download is paused.
  }

  func cancelDownload(_ track: Track) {
    // TODO
    
//    To cancel a download, you retrieve the download task from the corresponding Download in the dictionary of active downloads, and call cancel() on it to cancel the task. You then remove the download object from the dictionary of active downloads.
    if let download = activeDownloads[track.previewURL] {
      download.task?.cancel()
      activeDownloads[track.previewURL] = nil
    }
  }

  func resumeDownload(_ track: Track) {
    // TODO When the user resumes a download, you check the appropriate Download for the presence of resume data. If found, you create a new download task by invoking downloadTask(withResumeData:) with the resume data. If the resume data is absent for some reason, you create a new download task with the download URL.
//    In both cases, you start the task by calling resume(), and set the isDownloading flag of the Download to true, to indicate the download has resumed.
//    There’s only one thing left to do for these three functions to work properly: you need to show or hide the Pause/Resume and Cancel buttons, as appropriate. To do this, the TrackCell configure(track:downloaded:) method needs to know if the track has an active download, and whether it’s currently downloading.
//
    guard let download = activeDownloads[track.previewURL] else { return }
    if let resumeData = download.resumeData {
      download.task = downloadsSession.downloadTask(withResumeData: resumeData)
    } else {
      download.task = downloadsSession.downloadTask(with: download.track.previewURL)
    }
    download.task!.resume()
    download.isDownloading = true
    
  }

}
