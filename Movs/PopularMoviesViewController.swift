//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/15/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var movieStore : MovieStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieDBAPI.sharedInstance.getMovies() { (result) in
            switch result {
            case .success(let movies):
                self.movieStore.allMovies = movies
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        print(movieStore.allMovies.count)
        
        let width = (view.frame.size.width - 15) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: (width*1.3))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieStore.allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.movieLabel.text = movieStore.allMovies[indexPath.item].title
        
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let url = URL(string: baseURL + movieStore.allMovies[indexPath.item].poster_path)
        let data = try? Data(contentsOf: url!)
        cell.posterImage.image = UIImage(data: data!)
        
        //let width = (view.frame.size.width - 15) / 2
        //cell.posterImage.frame.size = CGSize(width: width/5, height: width/5)
        //getImageFromURL(MovieStore.sharedInstance.allMovies[indexPath.item].poster_path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

    
}

