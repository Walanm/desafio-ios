//
//  MovieStore.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import Foundation

class MovieStore {
    
    var allMovies = [Movie]()
    
    var favoriteMovies = [Movie]()
    
    static let sharedInstance = MovieStore()
    
    init() {
        MovieDBAPI.sharedInstance.getMovies() { (result) in
            switch result {
            case .success(let movies):
                self.allMovies = movies
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    /*func retriveMovies(){
    
        MovieDBAPI.sharedInstance.getMovies() { (result) in
            switch result {
            case .success(let movies):
                self.allMovies = movies
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
        
    }*/
    
    
}
