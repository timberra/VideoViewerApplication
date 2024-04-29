//
//  VideoDownloadManager.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI
import Combine

class VideoDownloadManager: ObservableObject {
    @Published var downloadProgress: Float = 0
    
    private var cancellable: AnyCancellable?
    
    func startDownload(video: Video) {
        let totalBytes = 100
        var downloadedBytes = 0
        cancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                downloadedBytes += 1
                self.downloadProgress = min(Float(downloadedBytes) / Float(totalBytes), 1.0)
                if downloadedBytes >= totalBytes {
                    self.cancellable?.cancel()
                }
            }
    }
    func cancelDownload() {
        cancellable?.cancel()
        downloadProgress = 0
    }
}

