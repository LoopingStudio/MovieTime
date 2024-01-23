//
//  PosterSection.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI

struct PosterSection: View {
    let title: String
    let list: [Movie]
    let padding: CGFloat
    
    var body: some View {
        VStack{
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(depth: 10)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(list){ movie in
                        MovieLittlePoster(movie: movie)
                    }
                }
                .padding(.horizontal, padding)
                .padding(.vertical, 60)
            }
            .padding(.horizontal, -padding)
            .padding(.vertical, -60)
        }
    }
}

struct BackdropSection: View {
    let title: String
    let list: [Movie]
    let padding: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(depth: 10)
                Spacer()
                Button{
                    
                } label: {
                    Text("Voir tout")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)
                        .tint(.white)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(list){ movie in
                        DetailMoviePoster(movie: movie)
                    }
                }
                .padding(.horizontal, padding)
                .padding(.vertical, 60)
            }
            .padding(.horizontal, -padding)
            .padding(.vertical, -60)
        }
    }
}


#Preview {
    PosterSection(title: "Tendances", list: [Movie.sample,
                                             Movie.sample,
                                             Movie.sample,
                                             Movie.sample,
                                             Movie.sample], padding: 16)
}
