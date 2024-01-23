//
//  MovieLittlePoster.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI
import NukeUI

struct MovieLittlePoster: View {
    let movie: Movie
    
    var posterWidth: CGFloat = 140
    var posterHeight: CGFloat = 210
    
    var body: some View {
        LazyImage(url: movie.fullPosterURL) { state in
            if let image = state.image {
                ZStack{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: posterWidth + 10, height: posterHeight + 10)
                        .continuousCorner(8)
                        .blur(radius: 30)
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: posterWidth, height: posterHeight)
                            .continuousCorner(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(LinearGradient(
                                        colors: [.white.opacity(0),
                                                 //                                         .white.opacity(0.05),
                                                 .white.opacity(0.1),
                                                 .white.opacity(0.4)],
                                        startPoint: .bottomTrailing,
                                        endPoint: .topLeading
                                    ), lineWidth: 1)
                            }
                            .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 8))
                            .hoverEffect(.automatic)
                    }
                    .frame(depth: 20)
                    .buttonStyle(.plain)
                    
                }
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.1))
                    .frame(width: posterWidth, height: posterHeight)
                    .padding(5)
            }
        }
    }
}

#Preview {
    MovieLittlePoster(movie: Movie.sample)
}
