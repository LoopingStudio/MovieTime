//
//  Movie.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation

struct Movie: Identifiable, Codable{
    let id: Int
    let movieTitle: String?
    let tvName: String?
    let overview: String
    let poster: String?
    let backdrop: String?
    let movieReleaseDate: String?
    let tvFirstAirDate: String?
    let vote: Double
    let mediaType: String?
    let character: String?
    
    var isMovie = true
    
    //Transform poster into a full url
    var fullPosterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster ?? "")")
    }
    
    var highResolutionPoster: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(poster ?? "")")
    }
    
    var fullBackdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop ?? poster ?? "")")
    }
    
    var title: String {
        let title = isMovie ? movieTitle : tvName
        return title ?? ""
    }
    
    var date: String {
        let date = isMovie ? movieReleaseDate : tvFirstAirDate
        return date ?? ""
    }
    
    var year: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = if let date = date.formatDate {
            dateFormatter.string(from: date)
        } else {
            ""
        }
        return year
    }
    
    func isIncluded()->Bool {
        return !self.title.lowercased().contains("Choufli") &&
        self.poster != nil &&
        !self.poster!.isEmpty
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case movieTitle = "title"
        case tvName = "name"
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case movieReleaseDate = "release_date"
        case tvFirstAirDate = "first_air_date"
        case vote = "vote_average"
        case mediaType = "media_type"
        case character
    }
    
    
    static var sample: Movie {
        let detail = """
    {
     "adult": false,
     "backdrop_path": "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
     "genre_ids": [
       16,
       28,
       12,
       878
     ],
     "id": 569094,
     "original_language": "en",
     "original_title": "Spider-Man: Across the Spider-Verse",
     "overview": "Après avoir retrouvé Gwen Stacy, Spider-Man, le sympathique héros originaire de Brooklyn, est catapulté à travers le Multivers, où il rencontre une équipe de Spider-Héros chargée d'en protéger l'existence. Mais lorsque les héros s'opposent sur la façon de gérer une nouvelle menace, Miles se retrouve confronté à eux et doit redéfinir ce que signifie être un héros afin de sauver les personnes qu'il aime le plus.",
     "popularity": 341.526,
     "poster_path": "/hvfwCeSTgsExmz9l31dKkfR83DH.jpg",
     "release_date": "2023-05-31",
     "title": "Spider-Man : Across the Spider-Verse",
     "video": false,
     "vote_average": 8.381,
     "vote_count": 5507
    }
    """
        
        let data = detail.data(using: .utf8)
        let movieDetail = try! JSONDecoder().decode(Movie.self, from: data!)
        return movieDetail
    }
}


/*{
 "adult": false,
 "backdrop_path": "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
 "genre_ids": [
 16,
 28,
 12,
 878
 ],
 "id": 569094,
 "original_language": "en",
 "original_title": "Spider-Man: Across the Spider-Verse",
 "overview": "Après avoir retrouvé Gwen Stacy, Spider-Man, le sympathique héros originaire de Brooklyn, est catapulté à travers le Multivers, où il rencontre une équipe de Spider-Héros chargée d'en protéger l'existence. Mais lorsque les héros s'opposent sur la façon de gérer une nouvelle menace, Miles se retrouve confronté à eux et doit redéfinir ce que signifie être un héros afin de sauver les personnes qu'il aime le plus.",
 "popularity": 341.526,
 "poster_path": "/hvfwCeSTgsExmz9l31dKkfR83DH.jpg",
 "release_date": "2023-05-31",
 "title": "Spider-Man : Across the Spider-Verse",
 "video": false,
 "vote_average": 8.381,
 "vote_count": 5507
 }*/
