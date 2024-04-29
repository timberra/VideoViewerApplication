//
//  VideoDetailView.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    @StateObject var videoDownloadManager = VideoDownloadManager()
    let video: Video
    
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: video.videoURL))
                .frame(height: 300)
            Text(video.name)
                .font(.title)
            Text(video.description)
                .padding()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if videoDownloadManager.downloadProgress > 0 {
                    ProgressBar(progress: videoDownloadManager.downloadProgress)
                    Button("Cancel Download") {
                        videoDownloadManager.cancelDownload()
                    }
                } else {
                    Button("Download Video") {
                        videoDownloadManager.startDownload(video: video)
                    }
                }
            }
        }
    }
}

struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        ProgressView(value: progress, total: 1)
            .progressViewStyle(LinearProgressViewStyle())
            .padding()
    }
}
