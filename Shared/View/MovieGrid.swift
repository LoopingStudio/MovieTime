//
//  MovieGrid.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

struct MovieGrid: View {
    var multiList: [Multi]
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(),GridItem(),GridItem(),GridItem()]) {
            ForEach(multiList){ multi in
                if multi.mediaType == "tv" || multi.mediaType == "movie"{
                    let media = multi.toMedia
                    MovieLittlePoster(movie: media)
                } else if multi.mediaType == "person"{
                    let person = multi.toPerson
                    VStack{
                        NavigationLink{
                            PersonDetailView(person: person)
                        } label: {
                            AsyncImage(url: person.fullPictureURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .frame(width: 100, height: 100)
                            }
                            Text(person.name)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    ForEach(person.knowFor) { media in
                        NavigationLink {
                            MovieDetailView(movie: media)
                        } label: {
                            MovieLittlePoster(movie: media)
                        }
                    }
                }
            }
        }
    }
}
