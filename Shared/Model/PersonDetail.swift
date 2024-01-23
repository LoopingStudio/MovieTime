//
//  PersonDetail.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 22/01/2024.
//

import Foundation

struct PersonDetail: Identifiable, Decodable{
    let id: Int
    let biography: String
    let birthDay: String
    let deathDay: String?
    let placeOfBirth: String
    let gender: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case biography
        case birthDay = "birthday"
        case deathDay = "deathday"
        case placeOfBirth = "place_of_birth"
        case gender
    }
}
/*{
 "adult": false,
 "also_known_as": [
   "브래들리 쿠퍼",
   "布莱恩·科兰斯顿",
   "Брэдли Купер",
   "برادلي كوبر",
   "ブラッドリー・クーパー",
   "แบรดลีย์ คูเปอร์",
   "布萊德利·古柏",
   "Μπράντλεϊ Κούπερ"
 ],
 "biography": "Bradley Cooper (né le 5 janvier 1975) est un acteur américain de cinéma, de théâtre et de télévision. Il est connu pour ses rôles de Will Tippin dans la série télévisée Alias, Phil Wenneck dans le film The Hangover 2009 (et ses suites), et Templeton \"Faceman\" Peck dans le film The A-Team 2010.",
 "birthday": "1975-01-05",
 "deathday": null,
 "gender": 2,
 "homepage": null,
 "id": 51329,
 "imdb_id": "nm0177896",
 "known_for_department": "Acting",
 "name": "Bradley Cooper",
 "place_of_birth": "Philadelphia, Pennsylvania, USA",
 "popularity": 39.665,
 "profile_path": "/lq68RaE8zK4lNaB49RWOukyorgn.jpg"
}*/
