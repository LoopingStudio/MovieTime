//
//  MovieCastResponse.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation

struct MultiSearchResponse: Codable {
    let results: [Multi]
}

struct Multi: Identifiable, Codable{
    let id: Int
    let name: String?
    let title: String?
    let posterPath: String?
    let profilePath: String?
    let backdropPath: String?
    let overview: String?
    let mediaType: String
    let releaseDate: String?
    let firstAirDate: String?
    let vote: Double?
    let knowFor: [Movie]?
    
    var toMedia: Movie {
        if mediaType == "tv" || mediaType == "movie"{
            var movie = Movie(id: id,
                              movieTitle: title,
                              tvName: name,
                              overview: overview ?? "No overview",
                              poster: posterPath ?? "",
                              backdrop: backdropPath,
                              movieReleaseDate: releaseDate,
                              tvFirstAirDate: firstAirDate,
                              vote: vote ?? 5,
                              mediaType: mediaType,
                              character: nil)
            movie.isMovie = mediaType == "movie"
            return movie
        }
        return Movie.sample
    }
    
    var toPerson: Person{
        if mediaType == "person" {
            return Person(id: id, name: name ?? "No name", picture: profilePath, knowFor: knowFor ?? [])
        }
        return Person.sample
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case posterPath = "poster_path"
        case profilePath = "profile_path"
        case backdropPath = "backdrop_path"
        case overview
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case vote
        case knowFor = "known_for"
    }
}
