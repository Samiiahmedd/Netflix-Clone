//
//  APICaller.swift
//  Netflix
//  Created by Sami Ahmed on 30/10/2023.

import Foundation

struct Constants {
    static let API_KEY = "c5a918ddbfa9adaa20c61ad500fd590f"
    static let baseURL = "https://api.themoviedb.org/"
    static let youtubeAPI_KEY = "AIzaSyA0wWliy6iF7vZHSxsLZ34uxewGtSHL3g0"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError : Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    //getTrendingMovies
    
    func getTrendingMovies(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    //getTrendingTvs
    func getTrendingTvs(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
            return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))

            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    //getUpcomingMovies
    
    func getUpcomingMovies(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL (string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIError.failedTogetData))

                
            }
        }
        task.resume()
        
    }
    
    
    //getPopulars
    
    func getPopulars(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL (string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIError.failedTogetData))

            }
        }
        task.resume()
    }
    
    
    //getTopRated
    
    func getTopRated(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL (string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIError.failedTogetData))

            }
        }
        task.resume()
    }
    
    
    //DiscoverMovies
    
    func getDiscoveryMovies(completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let url = URL (string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))

            }
        }
        task.resume()
    }
    
    //Search
    func search(with query: String,completion:@escaping (Result <[Title],Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))

            }
        }
        task.resume()
    }
    func getMovie(with query:String,completion:@escaping (Result <VideoElement,Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
               
                    completion(.success(results.items[0]))
                }catch{
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
                
            
    }
    task.resume()
        
    }
    
}
