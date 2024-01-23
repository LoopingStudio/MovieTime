//
//  Genre.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation

struct Genre: Identifiable, Codable{
    let id: Int
    let name: String
    
    static var samples: [Genre] {
        return [Genre(id: 1, name: "Action"),
                Genre(id: 2, name: "Aventure"),
                Genre(id: 3, name: "Drame")]
    }
}
