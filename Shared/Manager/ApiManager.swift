//
//  ApiManager.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import Foundation



class ApiManager: ObservableObject{
    
    private let API_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYWQ3ODQ0ZTNmNjRjZWNhZTQwYzU0MzRiY2Y1ZTZhNCIsInN1YiI6IjY1N2M2NjU5MTc2YTk0MTczNDAxNDJmZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OF6gAT3cV2hP9Lw-WXW_MYQfIQkmb4q8824UiL9hXD0"
    private let API_ENDPOINT = "https://api.themoviedb.org/3"
    
    @Published private(set) var isLoading = false
    @Published private(set) var trendingMovies: [Movie] = []
    @Published private(set) var trendingTV: [Movie] = []
    @Published private(set) var upComingMovies: [Movie] = []
    
    //Basic API Request that return a Decodable model
    private func fetchData<T: Decodable>(from route: String) async throws -> T {
        guard let url = URL(string: API_ENDPOINT + route) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(API_TOKEN)", forHTTPHeaderField: "Authorization")
        print("API Call : \(url.absoluteString)")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let res = try JSONDecoder().decode(T.self, from: data)
            print("API Call : \(route) OK")
            return res
        } catch {
            print("API Call : \(route) Error")
            throw error
        }
    }
    
    @MainActor
    func fetchTrends() async throws{
        isLoading = true
        trendingMovies = try await fetchMovieList(.trendingMovie)
        trendingTV = try await fetchMovieList(.trendingTV)
        upComingMovies = try await fetchMovieList(.upcomingMovie)
        isLoading = false
    }
    
    func fetchMovieList(_ movieListType: MovieListType) async throws -> [Movie]{
        let route = switch movieListType {
        case .trendingMovie:
            "/trending/movie/day?language=fr-FR"
        case .trendingTV:
            "/trending/tv/day?language=fr-FR"
        case .upcomingMovie:
            "/movie/upcoming?language=fr-FR&page=1&region=fr"
        }
        
        let res: MovieListResponse = try await fetchData(from: route)
        if movieListType == .trendingTV {
            let tvSeries = res.results.map {
                var tv = $0
                tv.isMovie = false
                return tv
            }
            return tvSeries
        }
        let results = res.results.filter { movie in
            return movie.isIncluded()
            }
        return results
    }
    
    @MainActor
    func fetchMediaData<T: Decodable>(of movie: Movie, fetchType: FetchType) async throws -> T {
        let route = "\(movie.isMovie ? "/movie" : "/tv")/\(movie.id)\(fetchType.rawValue)?language=fr-FR"
        
        switch fetchType {
        case .recommendations:
            if let res: MovieListResponse = try? await fetchData(from: route){
                let results = res.results.filter { movie in
                    return movie.isIncluded()
                }
                return results as! T
            }
            return [Movie]() as! T
        case .videos:
            let res: MovieVideoResponse = try await fetchData(from: route)
            return res.results as! T
        case .cast:
            let res: MovieCastResponse = try await fetchData(from: route)
            return Array(res.cast.prefix(10)) as! T
        default:
            return try await fetchData(from: route)
        }
    }
    
    @MainActor
    func fetchDetails(of person: Person) async throws -> PersonDetail {
        let route = "/person/\(person.id)?language=fr-FR"
        return try await fetchData(from: route)
    }
    
    @MainActor
    func fetchCredits(of person: Person) async throws -> [Movie] {
        let route = "/person/\(person.id)/combined_credits?language=fr-FR"
        let res: PersonCreditsResponse = try await fetchData(from: route)
        return res.cast
    }
//
//    //Fetching details from a movie
//    @MainActor
//    func fetchDetail(of movie: Movie) async throws -> MovieDetail {
//        let route = (movie.isMovie ? "/movie" : "/tv") + "/\(movie.id)?language=fr-FR"
//        return try await fetchData(from: route)
//    }
//    
//    //Fetching the cast of a movie
//    @MainActor
//    func fetchCast(of movie: Movie) async throws -> [CastMember] {
//        let route = (movie.isMovie ? "/movie" : "/tv") + "/\(movie.id)/credits?language=fr-FR"
//        let res: MovieCastResponse = try await fetchData(from: route)
//        return Array(res.cast.prefix(10))
//    }
//    
//    @MainActor
//    func fetchVideos(of movie: Movie) async throws -> [MovieVideo] {
//        let route = (movie.isMovie ? "/movie" : "/tv") + "/\(movie.id)/videos?language=fr-FR"
//        let res: MovieVideoResponse = try await fetchData(from: route)
//        return res.results
//    }
//    
//    @MainActor
//    func fetchSimilar(of movie: Movie) async throws -> [Movie] {
//        let route = (movie.isMovie ? "/movie" : "/tv") + "/\(movie.id)/similar?language=fr-FR"
//        let res: MovieListResponse = try await fetchData(from: route)
//        return res.results
//    }
//    
//    @MainActor
//    func fetchRecommandation(of movie: Movie) async throws -> [Movie] {
//        let route = (movie.isMovie ? "/movie" : "/tv") + "/\(movie.id)/recommendations?language=fr-FR"
//        let res: MovieListResponse = try await fetchData(from: route)
//        return res.results
//    }
    
    
    
    @MainActor
    func searchMovie(_ query: String) async throws -> [Multi] {
        let route = "/search/multi?query=\(query)&language=fr-FR&page=1"
        let res: MultiSearchResponse = try await fetchData(from: route)
        return res.results
    }
}

enum MovieListType {
    case trendingMovie, trendingTV, upcomingMovie
}

enum FetchType: String {
    case details = ""
    case recommendations = "/recommendations"
    case videos = "/videos"
    case cast = "/credits"
}
