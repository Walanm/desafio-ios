//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(MovieStore.sharedInstance.allMovies.count)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    
    
}
