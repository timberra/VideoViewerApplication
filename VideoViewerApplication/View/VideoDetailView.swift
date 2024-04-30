//
//  VideoDetailView.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    @State private var showAlert = false
    @StateObject var videoDownloadManager = VideoDownloadManager()
    @State private var isDownloading = false
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
                    ProgressView(value: videoDownloadManager.downloadProgress, total: 1)
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding(.trailing)
                    Button("Cancel Download") {
                        videoDownloadManager.cancelDownload()
                        isDownloading = false // Set isDownloading to false
                    }
                    .padding(.trailing)
                } else {
                    Button("Download Video") {
                        isDownloading = true
                        videoDownloadManager.startDownload(video: video)
                        showAlert = true
                    }
                    .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $showAlert) {
            CustomAlertView(downloadProgress: $videoDownloadManager.downloadProgress, onCancel: {
                showAlert = false
            })
            .background(Color(UIColor.systemBackground))
        }
    }
}
//MARK: - CustomAlertView
extension VideoDetailView {
    struct CustomAlertView: View {
        @Binding var downloadProgress: Float
        var onCancel: () -> Void
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.clear
                        .opacity(0.001)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .onTapGesture {}
                    VStack {
                        Text("Downloading...")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                        Text("Download progress: \(Int(downloadProgress * 100))%")
                            .padding()
                            .foregroundColor(Color(UIColor.label))
                        Button("Cancel") {
                            onCancel()
                        }
                        .padding()
                        .foregroundColor(Color.blue)
                    }
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .ignoresSafeArea()
        }
    }
}
