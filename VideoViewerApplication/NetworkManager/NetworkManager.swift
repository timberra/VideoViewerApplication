//
//  NetworkManager.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import SwiftUI
import Combine

class VideoStore: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isRefreshing = false
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchVideos()
    }

    func fetchVideos() {
        guard let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [String: [Video]].self, decoder: JSONDecoder())
            .map { $0["lessons"] ?? [] } // Extract 'lessons' array
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching videos: \(error.localizedDescription)")
                case .finished:
                    break
                }
                self.isRefreshing = false
            }, receiveValue: { videos in
                self.videos = videos
            })
            .store(in: &cancellables)
    }
}

