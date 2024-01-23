//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI
import NukeUI

struct MovieDetailView: View {
    @EnvironmentObject var apiManager: ApiManager
    @EnvironmentObject var watchList: WatchListManager
    
    var movie: Movie
    @State private var details: MovieDetail?
    @State private var cast: [CastMember] = []
    @State private var videos: [MovieVideo] = []
    @State private var recommendations: [Movie] = []
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack(alignment: .top){
                    VStack {
                        MoviePoster(movie: movie)
                            
                        HStack {
                            Text(movie.year)

                            if movie.isMovie {
                                Text(details?.runtime?.toHoursAndMinutes ?? .placeholder(length: 5))
                                    .redacted(details == nil)
                            } else {
                                Text("\(details?.numberOfSeasons ?? 0) saisons")
                                    .redacted(details == nil)
                            }
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    VStack(spacing: 32){
                        HStack {
                            VStack(alignment: .leading){
                                Text(details?.tagline ?? .placeholder(length: 25))
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                    .redacted(details == nil)
                                
                                VStack(alignment: .leading){
                                    Text("Genres")
                                        .bold()
                                        .frame(depth: 10)
                                    HStack{
                                        ForEach(details?.genres ?? Genre.samples){ genre in
                                            Text("\(genre.name)")
                                                .redacted(details == nil)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading){
                            Text("Synopsis")
                                .bold()
                            Text(movie.overview)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .frame(maxWidth: 600)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                
                VStack{
                    VStack(alignment: .leading){
                        Text("Casting")
                            .bold()
                            .frame(depth: 10)
                        CastList(cast: cast, padding: 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack{
                    VStack(alignment: .leading){
                        Text("Vidéos")
                            .bold()
                            .frame(depth: 10)
                        VideoList(videos: videos)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if !recommendations.isEmpty {
                    PosterSection(title: "Recommandations", list: recommendations.sorted(by: { $0.vote>$1.vote}), padding: 32)
                }
            }
            .padding([.horizontal, .bottom], 32)
            .frame(maxWidth: .infinity)
            .navigationTitle(movie.title)
            .ornament(attachmentAnchor: .scene(.topTrailing)) {
                HStack(spacing: 16){
                    Button(action: {
                        watchList.toggleMovie(movie: movie)
                    }) {
                        Image(systemName: watchList.isMovieToWatch(movieID: movie.id)
                              ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.primary)
                        .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    
                    
                    Button(action: {
                        watchList.toggleMovie(movie: movie)
                    }) {
                        Image(systemName: "star")
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                        }
                    .buttonStyle(.plain)
                    Button(action: {
                        
                    }) {
                        Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                        .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(16)
                .glassBackgroundEffect()
                .frame(depth: 35)
                .padding(.trailing, 300)
            }
            
        }
        .task {
            do {
                async let details: MovieDetail = try apiManager.fetchMediaData(of: movie, fetchType: .details)
                    async let cast: [CastMember] = try apiManager.fetchMediaData(of: movie, fetchType: .cast)
                    async let videos: [MovieVideo] = try apiManager.fetchMediaData(of: movie, fetchType: .videos)
                    async let recommendations: [Movie] = try apiManager.fetchMediaData(of: movie, fetchType: .recommendations)

                    // Attendre l'achèvement de toutes les tâches
                    self.details = try await details
                    self.cast = try await cast
                    self.videos = try await videos
                    self.recommendations = try await recommendations
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack{
        MovieDetailView(movie: Movie.sample)
    }
    .preferredColorScheme(.dark)
    .environmentObject(ApiManager())
    .environmentObject(WatchListManager())
}


