//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/15/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
        
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieStore : MovieStore!
    var filteredMovieResults = [Movie]()
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        
        activityIndicator.startAnimating()
        
        MovieDBAPI.sharedInstance.getMovies(page: self.page) { (result) in
            switch result {
            case .success(let movies):
                self.movieStore.allMovies = movies
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
            self.filteredMovieResults = self.movieStore.allMovies;
            self.collectionView.reloadSections(IndexSet(integer: 0))
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        print(movieStore.allMovies.count)
        print(movieStore.allGenres)
        
        let width = (view.frame.size.width - 15) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: (width*1.3))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filteredMovieResults.count
    }
    
    
    // Define o conteúdo das células do grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.movieLabel.text = filteredMovieResults[indexPath.item].title
        cell.movieLabel.adjustsFontSizeToFitWidth = true
        cell.movieLabel.minimumScaleFactor = 0.2
        
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let url = URL(string: baseURL + filteredMovieResults[indexPath.item].poster_path)
        let data = try? Data(contentsOf: url!)
        cell.posterImage.image = UIImage(data: data!)
        
        if(MovieStore.sharedInstance.hasMovieInFavorites(movie: filteredMovieResults[indexPath.item])){
            cell.favoriteImage.image = UIImage(named: "favorite_full_icon")
        } else {
            cell.favoriteImage.image = UIImage(named: "favorite_gray_icon")
        }
        
        
        return cell
    }
    
    
    // Carrega mais filmes ao chegar no último item visível do grid
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastElement = movieStore.allMovies.count - 1
        //let lastElement = filteredMovieResults.count - 1
        if indexPath.row == lastElement {
            self.page += 1;
            activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
            MovieDBAPI.sharedInstance.getMovies(page: self.page) { (result) in
                switch result {
                case .success(let movies):
                    self.movieStore.allMovies += movies
                case .failure(let error):
                    fatalError("error: \(error.localizedDescription)")
                }
                
                self.filteredMovieResults = self.movieStore.allMovies
                self.collectionView.reloadSections(IndexSet(integer: 0))
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
        }
        
    
    }
    
    private func setUpSearchBar () {
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredMovieResults = movieStore.allMovies;
            self.collectionView.reloadSections(IndexSet(integer: 0))
            return
        }
        filteredMovieResults = movieStore.allMovies.filter({movie -> Bool in
            guard let text = searchBar.text else { return false }
            return movie.title.lowercased().contains(text.lowercased())
        })
        self.collectionView.reloadSections(IndexSet(integer: 0))
        
    }
    
    //Faz a função de segue pra próxima view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.currentMovie = filteredMovieResults[indexPath.item]
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
 
    }
    

    
}

