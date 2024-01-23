//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    @StateObject var apiManager = ApiManager()
    @StateObject var watchList = WatchListManager()
    var body: some Scene {
        WindowGroup {
            MovieTabView()
                .preferredColorScheme(.dark)
                .environmentObject(apiManager)
                .environmentObject(watchList)
        }
    }
}
