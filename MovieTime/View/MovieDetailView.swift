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
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                MoviePoster(movie: movie)
                
                VStack(spacing: 32){
                    HStack {
                        VStack(alignment: .leading){
                            Text(movie.title)
                                .font(.system(size: 24, weight: .semibold))
                            Text(details?.tagline ?? .placeholder(length: 25))
                                .foregroundStyle(.secondary)
                                .redacted(details == nil)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            if movie.isMovie {
                                Text(details?.runtime?.toHoursAndMinutes ?? "1h58")
                                    .redacted(details == nil)
                            } else {
                                Text("\(details?.numberOfSeasons ?? 0) saisons")
                                    .redacted(details == nil)
                            }
                            Text(movie.year)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading){
                        Text("Synopsis")
                            .bold()
                        Text(movie.overview)
                            .frame(maxWidth: .infinity)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Genres")
                            .bold()
                        HStack{
                            ForEach(details?.genres ?? Genre.samples){ genre in
                                Text("\(genre.name)")
                                    .redacted(details == nil)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading){
                        Text("Casting")
                            .bold()
                        CastList(cast: cast)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            do {
                try await details = apiManager.fetchDetail(of: movie.id, movie.isMovie)
                try await cast = apiManager.fetchCast(of: movie.id, movie.isMovie)
                try await videos = apiManager.fetchVideos(of: movie.id, movie.isMovie)
            } catch {
                print(error.localizedDescription)
            }
        }
        .navigationBarItems(
            trailing:
                HStack {
                    Button(action: {
                        watchList.toggleMovie(movie: movie)
                    }) {
                        Image(systemName: watchList.isMovieToWatch(movieID: movie.id)
                              ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.white)
                    }
                }
        )
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
