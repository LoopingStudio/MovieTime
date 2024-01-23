//
//  MovieTabView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

struct MovieTabView: View {
    var body: some View {
        TabView{
            HomeMovieView()
                .tabItem {
                    Label("Tendances", systemImage: "chart.xyaxis.line")
                }
            SearchView()
                .tabItem {
                    Label("Recherche", systemImage: "magnifyingglass")
                }
            WatchListView()
                .tabItem {
                    Label("Ma liste", systemImage: "list.bullet.clipboard")
                }
        }
    }
}

#Preview {
    MovieTabView()
        .environmentObject(ApiManager())
        .environmentObject(WatchListManager())
        .preferredColorScheme(.dark)
}
