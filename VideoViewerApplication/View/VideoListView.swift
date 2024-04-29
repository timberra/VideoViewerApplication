//
//  VideoListView.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI

struct VideoListView: View {
    @ObservedObject var videoStore: VideoStore
    @State private var isRefreshing = false

    var body: some View {
        NavigationView {
            List {
                ForEach(videoStore.videos) { video in
                    NavigationLink(destination: VideoDetailView(video: video)) {
                        HStack {
                            AsyncImage(url: video.thumbnail) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }
                            Text(video.name)
                        }
                    }
                }
            }
            .navigationTitle("Videos")
            .modifier(PullToRefreshModifier(isRefreshing: $isRefreshing) {
                self.videoStore.fetchVideos()
            })
        }
    }
}
