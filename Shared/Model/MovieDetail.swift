//
//  MovieDetail.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation

struct MovieDetail: Codable {
    
    let tagline: String
    let genres: [Genre]
    let runtime: Int?
    let numberOfSeasons: Int?
    
    enum CodingKeys: String, CodingKey {
        case tagline
        case genres
        case runtime
        case numberOfSeasons = "number_of_seasons"
    }
    
    var isMovie = true
   
    var sample: MovieDetail {
        let detail = """
    {
      "adult": false,
      "backdrop_path": "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
      "belongs_to_collection": {
        "id": 573436,
        "name": "Spider-Man: Spider-Verse Collection",
        "poster_path": "/eD4bGQNfmqExIAzKdvX5gDHhI2.jpg",
        "backdrop_path": "/oC5S5pdfzPiQC4us05uDMT7v5Ng.jpg"
      },
      "budget": 100000000,
      "genres": [
        {
          "id": 16,
          "name": "Animation"
        },
        {
          "id": 28,
          "name": "Action"
        },
        {
          "id": 12,
          "name": "Adventure"
        },
        {
          "id": 878,
          "name": "Science Fiction"
        }
      ],
      "homepage": "https://www.acrossthespiderverse.movie",
      "id": 569094,
      "imdb_id": "tt9362722",
      "original_language": "en",
      "original_title": "Spider-Man: Across the Spider-Verse",
      "overview": "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.",
      "popularity": 341.526,
      "poster_path": "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",
      "production_companies": [
        {
          "id": 5,
          "logo_path": "/71BqEFAF4V3qjjMPCpLuyJFB9A.png",
          "name": "Columbia Pictures",
          "origin_country": "US"
        },
        {
          "id": 2251,
          "logo_path": "/5ilV5mH3gxTEU7p5wjxptHvXkyr.png",
          "name": "Sony Pictures Animation",
          "origin_country": "US"
        },
        {
          "id": 77973,
          "logo_path": "/9y5lW86HnxKUZOFencYk3TIIRCM.png",
          "name": "Lord Miller",
          "origin_country": "US"
        },
        {
          "id": 84041,
          "logo_path": "/nw4kyc29QRpNtFbdsBHkRSFavvt.png",
          "name": "Pascal Pictures",
          "origin_country": "US"
        },
        {
          "id": 14439,
          "logo_path": null,
          "name": "Arad Productions",
          "origin_country": "US"
        },
        {
          "id": 7505,
          "logo_path": "/837VMM4wOkODc1idNxGT0KQJlej.png",
          "name": "Marvel Entertainment",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "US",
          "name": "United States of America"
        }
      ],
      "release_date": "2023-05-31",
      "revenue": 690500000,
      "runtime": 140,
      "spoken_languages": [
        {
          "english_name": "English",
          "iso_639_1": "en",
          "name": "English"
        },
        {
          "english_name": "Hindi",
          "iso_639_1": "hi",
          "name": "हिन्दी"
        },
        {
          "english_name": "Italian",
          "iso_639_1": "it",
          "name": "Italiano"
        },
        {
          "english_name": "Spanish",
          "iso_639_1": "es",
          "name": "Español"
        }
      ],
      "status": "Released",
      "tagline": "It's how you wear the mask that matters.",
      "title": "Spider-Man: Across the Spider-Verse",
      "video": false,
      "vote_average": 8.38,
      "vote_count": 5510
    }
    """
        
        let data = detail.data(using: .utf8)
        let movieDetail = try! JSONDecoder().decode(MovieDetail.self, from: data!)
        return movieDetail
    }
   
}