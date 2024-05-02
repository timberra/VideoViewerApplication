//
//  VideoViewerApplicationTests.swift
//  VideoViewerApplicationTests
//
//  Created by liga.griezne on 29/04/2024.
//

import XCTest
@testable import VideoViewerApplication

class VideoDownloadManagerTests: XCTestCase {
    
    var videoDownloadManager: VideoDownloadManager!
    
    override func setUpWithError() throws {
        videoDownloadManager = VideoDownloadManager()
    }
    
    override func tearDownWithError() throws {
        videoDownloadManager = nil
    }
    
    func testStartDownload() throws {
        let videoURL = URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!
        let thumbnailURL = URL(string: "https://static.vecteezy.com/system/resources/thumbnails/005/939/000/small/simple-test-icon-editable-48-pixel-free-vector.jpg")!
        let video = Video(id: 1, name: "Test Video", description: "Test Description", thumbnail: thumbnailURL, videoURL: videoURL)
        
        let progressExpectation = expectation(description: "Download progress should increase")
        
        // Start the download
        videoDownloadManager.startDownload(video: video)
        
        // Wait for a brief moment to allow the progress to update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert that the download progress has increased
            XCTAssertGreaterThan(self.videoDownloadManager.downloadProgress, 0)
            
            // Fulfill the expectation
            progressExpectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled or timeout after a certain duration
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testCancelDownload() throws {
        let videoURL = URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!
        let thumbnailURL = URL(string: "https://static.vecteezy.com/system/resources/thumbnails/005/939/000/small/simple-test-icon-editable-48-pixel-free-vector.jpg")!
        let video = Video(id: 1, name: "Test Video", description: "Test Description", thumbnail: thumbnailURL, videoURL: videoURL)
        
        videoDownloadManager.startDownload(video: video)
        videoDownloadManager.cancelDownload()
        
        // Assert that the download progress is 0 after canceling
        XCTAssertEqual(videoDownloadManager.downloadProgress, 0)
    }
    
    func testDownloadProgress() throws {
        // Ensure videoDownloadManager is initialized
        XCTAssertNotNil(videoDownloadManager, "VideoDownloadManager should not be nil")
        
        guard let videoDownloadManager = videoDownloadManager else {
            XCTFail("videoDownloadManager is nil")
            return
        }
        
        let thumbnailURL = URL(string: "https://static.vecteezy.com/system/resources/thumbnails/005/939/000/small/simple-test-icon-editable-48-pixel-free-vector.jpg")!
        let videoURL = URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!
        let video = Video(id: 1, name: "Test Video", description: "Test Description", thumbnail: thumbnailURL, videoURL: videoURL)
        videoDownloadManager.startDownload(video: video)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Assert that the download progress has increased
            XCTAssertGreaterThan(videoDownloadManager.downloadProgress, 0)
        }
    }


}
