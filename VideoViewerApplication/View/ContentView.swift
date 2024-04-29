//
//  ContentView.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoStore = VideoStore()

    var body: some View {
        VideoListView(videoStore: videoStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
