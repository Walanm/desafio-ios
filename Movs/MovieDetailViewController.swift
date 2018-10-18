//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/17/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var currentMovie: Movie!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let url = URL(string: baseURL + currentMovie.poster_path)
        let data = try? Data(contentsOf: url!)
        posterImage.image = UIImage(data: data!)
        
        titleLabel.text = currentMovie.title
        
        let reqIndex = currentMovie.release_date.index(currentMovie.release_date.startIndex, offsetBy: 4)
        releaseDateLabel.text = String(currentMovie.release_date[..<reqIndex])
        
        genresLabel.text = currentMovie.printGenres(genreList: MovieStore.sharedInstance.allGenres)
        genresLabel.adjustsFontSizeToFitWidth = true
        
        overviewLabel.text = currentMovie.overview
        
        loadLikeBtn()
        
        print(currentMovie.title)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btn_Like(_ sender: Any) {
        print("Funciona")
        
        if (!MovieStore.sharedInstance.hasMovieInFavorites(movie: currentMovie)){
            MovieStore.sharedInstance.favoriteMovies.append(currentMovie)
            
            MovieStore.sharedInstance.saveMoviesToDisk(movies: MovieStore.sharedInstance.favoriteMovies)
            
            loadLikeBtn()
            
            print("Favoritou")
        } else {
            
            print("Já é favorito")
            
        }
        
        
    }
    
    func loadLikeBtn () {
        
        if(MovieStore.sharedInstance.hasMovieInFavorites(movie: currentMovie)){
            likeBtn.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
            let liked = NSAttributedString(string: "Liked!",
                                       attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
            likeBtn.setAttributedTitle(liked, for: .normal)
        } else {
            let like = NSAttributedString(string: "Like",
                                         attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
            likeBtn.setImage(UIImage(named: "favorite_empty_icon.png"), for: .normal)
            likeBtn.setAttributedTitle(like, for: .normal)
            
        }
        
    }
    
    
    
    
    
   
    
    
    
    
}
