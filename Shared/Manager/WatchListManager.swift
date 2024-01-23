//
//  WatchListManager.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

class WatchListManager: ObservableObject{
    
    @AppStorage("WatchList") var watchList: [Movie] = []
    
    func toggleMovie(movie: Movie){
        if isMovieToWatch(movieID: movie.id) {
            watchList.removeAll { $0.id == movie.id}
        } else {
            watchList.append(movie)
        }
        
    }
    
    func isMovieToWatch(movieID: Int) -> Bool{
        return watchList.contains { $0.id == movieID}
    }
}
