//
//  Movie.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import Foundation
import CoreData

// Estrutura pra lista de gêneros
struct Genre: Codable {
    let id: Int
    let name: String
    
}

// Model dos filmes
class Movie: Codable {
    let id: Int
    let poster_path: String
    let title: String
    let genre_ids: [Int]
    let release_date: String
    let overview: String
    
    
    init(id: Int, poster_path: String, title: String, genre_ids: [Int], release_date: String, overview: String) {
        self.id = id
        self.poster_path = poster_path
        self.title = title
        self.genre_ids = genre_ids
        self.release_date = release_date
        self.overview = overview
        
    }
    
    // Retorna a lista de gêneros de um filme
    func printGenres (genreList: [Genre]) -> String {
        var output = ""
        for id in self.genre_ids {
            output += genreName(id: id, genreList: genreList)
            if (id != self.genre_ids.last){
                output += ", "
            }
        }
        
        return output
        
    }
    
    // Retorna o nome de um gênero
    func genreName (id: Int, genreList: [Genre]) -> String {
        for i in 0...(genreList.count-1) {
            if(id == genreList[i].id) {
                return genreList[i].name
            }
        }
        return ""
    }
    
}
