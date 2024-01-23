//
//  DetailMoviePoster.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI
import NukeUI

struct DetailMoviePoster: View {
    let movie: Movie
    
    var posterWidth: CGFloat = 210
    var posterHeight: CGFloat = 140
    
    var body: some View {
        AsyncImage(url: movie.fullBackdropURL) { image in
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
                        .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 8))
                        .hoverEffect(.automatic)
                }
                .frame(depth: 30)
                .buttonStyle(.plain)
            }
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.1))
                .frame(width: posterWidth, height: posterHeight)
                .padding(5)
        }
    }
}


#Preview {
    NavigationStack{
        DetailMoviePoster(movie: Movie.sample)
    }
}
