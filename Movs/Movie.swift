//
//  Movie.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
    
}

class Movie: Codable {
    let id: Int
    let poster_path: String
    let title: String
    let release_date: String
    let overview: String
    
    
    init(id: Int, poster_path: String, title: String, release_date: String, overview: String) {
        self.id = id
        self.poster_path = poster_path
        self.title = title
        self.release_date = release_date
        self.overview = overview
        
    }
}
