//
//  ContentView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI
import NukeUI

struct HomeMovieView: View {
    @EnvironmentObject var apiManager: ApiManager
    
    @State private var searchText: String = ""
    @State private var error: String = ""
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty{
            return apiManager.trendingMovies
        } else {
            return apiManager.trendingMovies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var trendingMovies: [Movie]{
        var trendingMovies = apiManager.trendingMovies
        if !trendingMovies.isEmpty {
            trendingMovies.removeFirst()
        }
        return trendingMovies
    }
    
    var topTrendingMovie: Movie? {
        return apiManager.trendingMovies.first
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                if !error.isEmpty {
                    Text(error)
                } else if apiManager.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 48){
                            if let topTrendingMovie{
                                VStack{
                                    LazyImage(url: topTrendingMovie.fullBackdropURL) { state in
                                        if let image = state.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: proxy.size.width, height: proxy.size.width*2/3, alignment: .bottom)
                                        } else if state.error != nil {
                                            Color.red // Indicates an error
                                        } else {
                                            Rectangle()
                                                .frame(height: proxy.size.width*2/3)
                                        }
                                    }
                                    .overlay(alignment: .bottom) {
                                        ZStack {
                                            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                                                .frame(height: 32)
                                        }
                                    }
                                    .padding(.horizontal, -16)
                                    
                                    HStack{
                                        Text("Detail")
                                            .bold()
                                            .padding(.horizontal, 16)
                                            .frame(height: 32)
                                            .background{
                                                Capsule()
                                                    .stroke(lineWidth: 1)
                                            }
                                        Image(systemName: "eye")
                                            .frame(width: 32, height: 32)
                                            .background{
                                                Circle()
                                                    .stroke(lineWidth: 1)
                                            }
                                        Image(systemName: "star")
                                            .frame(width: 32, height: 32)
                                            .background{
                                                Circle()
                                                    .stroke(lineWidth: 1)
                                            }
                                    }
                                }
                            }
                            PosterSection(title: "Tendances", list: trendingMovies, padding: 16)
                            PosterSection(title: "Séries", list: apiManager.trendingTV, padding: 16)
                            BackdropSection(title: "Prochainement", list: apiManager.upComingMovies, padding: 16)
                        }
                        .padding(.horizontal, 16)
                    }
                    .ignoresSafeArea(edges: .top)
                }
            }
        }
        .overlay(alignment: .top) {
            GeometryReader { proxy in
                VariableBlurView(maxBlurRadius: 8)
                    .frame(height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
        }
        .task {
            do {
                try await apiManager.fetchTrends()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}

#Preview {
    HomeMovieView()
        .environmentObject(ApiManager())
        .environmentObject(WatchListManager())
        .preferredColorScheme(.dark)
}
