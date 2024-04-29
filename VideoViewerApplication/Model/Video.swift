//
//  Video.swift
//  VideoViewerApplication
//
//  Created by liga.griezne on 29/04/2024.
//

import Foundation

struct Video: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: URL
    let videoURL: URL

    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail, videoURL = "video_url"
    }
}

