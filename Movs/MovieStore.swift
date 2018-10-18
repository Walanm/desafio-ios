//
//  MovieStore.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import Foundation

// Singleton para armazenar as coleções de filmes e gerenciar conjuntos de filmes
// Trata a persistência de arquivos (em json)
class MovieStore {
    
    var allMovies = [Movie]()
    
    var allGenres = [Genre]()
    
    var favoriteMovies = [Movie]()
    
    static let sharedInstance = MovieStore()
    
    
    func hasMovieInFavorites(movie: Movie) -> Bool {
        
        for item in self.favoriteMovies {
            if (movie.id == item.id){
                return true
            }
        }
        
        return false
    }
    
    func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
    
    func saveMoviesToDisk(movies: [Movie]) {
        // 1. Create a URL for documents-directory/posts.json
        let url = getDocumentsURL().appendingPathComponent("movies.json")
        // 2. Endcode our [Post] data to JSON Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            // 3. Write this data to the url specified in step 1
            try data.write(to: url, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getMoviesFromDisk() -> [Movie] {
        // 1. Create a url for documents-directory/posts.json
        let url = getDocumentsURL().appendingPathComponent("movies.json")
        let fileExists = (try? url.checkResourceIsReachable()) ?? false
        if (fileExists) {
            let decoder = JSONDecoder()
            do {
                // 2. Retrieve the data on the file in this path (if there is any)
                let data = try Data(contentsOf: url, options: [])
                // 3. Decode an array of Posts from this Data
                let movies = try decoder.decode([Movie].self, from: data)
                return movies
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            print("File not found")
            return []
        }
        
    }
    
    
}
