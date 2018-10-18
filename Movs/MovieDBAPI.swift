//
//  MovieDBAPI.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import Foundation

// Estrutura compatível com as tags do request de generos da API
struct FetchedGenres: Codable {
    
    let genres: [Genre]
    
}

// Estrutura compatível com as tags do request de filmes da API
struct FetchedMovies: Codable {
    
    let results: [Movie]
    
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

// Singleton que gerencia a comunicação com a API
class MovieDBAPI: NSObject {
    
    static let sharedInstance = MovieDBAPI()
    
    func getMovies(page: Int, completion: ((Result<[Movie]>) -> Void)?) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?page=" + String(page) + "&api_key=d70bcce17ca9372d7b63847f4b703452") else { fatalError("Could not create URL from components")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    // Now we have jsonData, Data representation of the JSON returned to us
                    // from our URLRequest...
                    
                    // Create an instance of JSONDecoder to decode the JSON data to our
                    // Codable struct
                    let decoder = JSONDecoder()
                    
                    do {
                        // We would use Post.self for JSON representing a single Post
                        // object, and [Post].self for JSON representing an array of
                        // Post objects
                        let movies = try decoder.decode(FetchedMovies.self, from: jsonData)
                        //print(movies.results)
                        completion?(.success(movies.results))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
    func getGenres(completion: ((Result<[Genre]>) -> Void)?) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=d70bcce17ca9372d7b63847f4b703452") else { fatalError("Could not create URL from components")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {

                    let decoder = JSONDecoder()
                    
                    do {
                        let genreList = try decoder.decode(FetchedGenres.self, from: jsonData)
                        //print(genreList.genres)
                        completion?(.success(genreList.genres))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}


