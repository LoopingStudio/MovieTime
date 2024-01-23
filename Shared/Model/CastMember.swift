//
//  CastMember.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation

struct CastMember: Identifiable, Codable{
    let id: Int
    let name: String
    let character: String?
    let picture: String?
    
    //Transform cast picture into a full url
    var fullPictureURL: URL? {
        if let picture {
            return URL(string: "https://media.themoviedb.org/t/p/w150_and_h150_face\(picture)")
        }
        return nil
    }
    
    var toPerson: Person {
        return Person(id: id, name: name, picture: picture, knowFor: [])
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case picture = "profile_path"
    }
    
    static var samples: [CastMember] {
        return [CastMember(id: 1, name: "Miles Morales", character: "Spider-Man Miles", picture: ""),
                CastMember(id: 2, name: "Gwen Stacy", character: "Spider-Gwen", picture: ""),
                CastMember(id: 3, name: "Peter Parker", character: "Spider-Man", picture: ""),
                CastMember(id: 4, name: "Eddie Brock", character: "Venom", picture: ""),
        ]
    }
}
