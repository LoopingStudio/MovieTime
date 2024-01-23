//
//  SearchView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @State private var searchResults: [Multi] = []
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var error = ""
    var body: some View {
        NavigationStack{
            if isLoading{
                ProgressView()
            } else if searchResults.isEmpty {
                VStack{
                    Spacer()
                    if error.isEmpty{
                        Text(searchText.isEmpty ? "Veuillez effectuer une recherche" : "Aucun resultat")
                    } else {
                        Text(error)
                    }
                    Spacer()
                }
            } else {
                ScrollView(showsIndicators: false){
                    MovieGrid(multiList: searchResults)
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) {
            if searchText.count > 3 {
                Task{
                    do {
                        error = ""
                        isLoading = true
                        searchResults = try await apiManager.searchMovie(searchText)
                        isLoading = false
                    } catch{
                        print(error.localizedDescription)
                        self.error = error.localizedDescription
                        isLoading = false
                    }
                }
            } else if searchText.isEmpty{
                error = ""
                isLoading = false
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(ApiManager())
        .environmentObject(WatchListManager())
}
