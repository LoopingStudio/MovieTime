//
//  MovieVideo.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 22/01/2024.
//

import Foundation
import YouTubePlayerKit

struct MovieVideo: Identifiable, Decodable, Equatable{
    let id: String
    let name: String
    let site: String
    let key: String
    let official: Bool
    let type: String
    
    var thumbnail: URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
    var youtubePlayer: YouTubePlayer {
        return YouTubePlayer(source: .video(id: key), configuration: YouTubePlayer.Configuration(fullscreenMode: .system, autoPlay: true))
    }
}
/*{
 "iso_639_1": "fr",
 "iso_3166_1": "FR",
 "name": "Bande-annonce officielle 2 [VOSTFR]",
 "key": "hrCX4trbaNE",
 "site": "YouTube",
 "size": 1080,
 "type": "Trailer",
 "official": true,
 "published_at": "2023-04-04T07:04:46.000Z",
 "id": "6472a0e5dd731b2d7799e051"
}*/
