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
                        VStack(spacing: 48) {
                            HStack(alignment: .top, spacing: 32){
                                FirstTrendingMoviePoster(movie: topTrendingMovie, proxy: proxy)
                                    .padding([.top, .leading], 16)

                            
                                VStack(spacing: 48){
                                    PosterSection(title: "Tendances", list: trendingMovies, padding: 64)
                                    PosterSection(title: "Séries", list: apiManager.trendingTV, padding: 64)
                                }
                                .padding(.horizontal, 32)
                            }
                            BackdropSection(title: "Prochainement", list: apiManager.upComingMovies, padding: 32)
                        }
                        .padding(32)
                    }
                }
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

struct FirstTrendingMoviePoster: View {
    var movie: Movie?
    let proxy: GeometryProxy
    var body: some View {
        VStack{
            if let movie {
                NavigationLink{
                    MovieDetailView(movie: movie)
                } label: {
                    LazyImage(url: movie.highResolutionPoster) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 500*2/3, height: 500, alignment: .bottom)
                                .continuousCorner(16)
                        } else if state.error != nil {
                            Color.red // Indicates an error
                        } else {
                            Rectangle()
                                .frame(width: 500*2/3, height: 500)
                                .continuousCorner(16)
                        }
                    }
                    .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 16))
                    .hoverEffect(.automatic)
                }
                .frame(depth: 30)
                .buttonStyle(.plain)
            }
            HStack{
                Text("Détails")
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
}
