//
//  TheVisionMovieApp.swift
//  TheVisionMovie
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI

@main
struct MovieTimeVisionApp: App {
    @StateObject var apiManager = ApiManager()
    @StateObject var watchList = WatchListManager()
    @StateObject var youtubeManager = YoutubeManager()
    var body: some Scene {
        WindowGroup {
            MovieTabView()
                .frame(
                    minWidth: 800, maxWidth: 1400,
                    minHeight: 600, maxHeight: 900
                )
                .preferredColorScheme(.dark)
                .environmentObject(apiManager)
                .environmentObject(watchList)
                .environmentObject(youtubeManager)
        }
        .defaultSize(CGSize(width: 1200, height: 800))
        .windowResizability(.contentSize)
        
        WindowGroup (id: "YoutubePlayer"){
            FullscreenYoutubeView()
                .frame(
                    minWidth: 640, maxWidth: 3840,
                    minHeight: 540, maxHeight: 2160
                )
                .environmentObject(youtubeManager)
        }
        .defaultSize(CGSize(width: 960, height: 540))
        .windowResizability(.contentSize)
    }
}
