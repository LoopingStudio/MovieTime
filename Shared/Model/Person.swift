//
//  Person.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 22/01/2024.
//

import Foundation

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
    let picture: String?
    let knowFor: [Movie]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture = "profile_path"
        case knowFor = "known_for"
    }
    
    var fullPictureURL: URL? {
        if let picture {
            return URL(string: "https://image.tmdb.org/t/p/w500\(picture)")
        }
        return nil
    }
    
    static var sample: Person {
        return Person(id: 1, name: "Bradley Cooper", picture: "/cckcYc2v0yh1tc9QjRelptcOBko.jpg", knowFor: [Movie.sample,
                                                                                              Movie.sample,
                                                                                              Movie.sample])
    }
}
