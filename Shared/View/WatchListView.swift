//
//  WatchListView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

enum TabSelection: String {
    case toWatch = "Films à regarder"
    case favorites = "Films favoris"
    static var allCases: [TabSelection] {
        return [.toWatch, .favorites]
    }
}

struct WatchListView: View {
    @EnvironmentObject var watchListManager: WatchListManager
    @State private var tabSelection: TabSelection = .toWatch
    var body: some View {
        NavigationStack{
            VStack{
                Picker("List type", selection: $tabSelection) {
                    Text("Films à regarder")
                        .tag(TabSelection.toWatch)
                    Text("Films favoris")
                        .tag(TabSelection.favorites)
                }
                .pickerStyle(.segmented)
                switch tabSelection {
                case .toWatch:
                    ScrollView(showsIndicators: false){
                        if watchListManager.watchList.isEmpty{
                            Text("Vous n'avez aucun film à voir")
                                .bold()
                        } else {
//                            MovieGrid(movieList: watchListManager.watchList)
                        }
                    }
                    .navigationTitle("Films à regarder")
                case .favorites:
                    VStack {
                        Text("Favoris")
                        Spacer()
                    }
                    .navigationTitle("Films favoris")
                }
            }
        }
    }
}

#Preview {
    WatchListView()
        .environmentObject(WatchListManager())
        .preferredColorScheme(.dark)
}
