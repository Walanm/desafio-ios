//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Walan Marcel Teles Oliveira on 10/12/18.
//  Copyright © 2018 Walan Marcel Teles Oliveira. All rights reserved.
//

import UIKit

// Controller da lista de favoritos
// Desfavorita um filme caso seja arrastado para a esquerda
class FavoritesTableViewController: UITableViewController {
    
    //var movieStore : MovieStore!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MovieStore.sharedInstance.favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Create or grab a reuseable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let favMovie = MovieStore.sharedInstance.favoriteMovies[indexPath.row]
        
        cell.textLabel!.text = favMovie.title as String
        
        return cell
    }
    
    var deleteMovieIndexPath: IndexPath? = nil
    
    // Disponibiliza o botão de unfavorite
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteMovieIndexPath = indexPath
            let movieToDelete = MovieStore.sharedInstance.favoriteMovies[indexPath.row]
            confirmDelete(movieToDelete)
        }
    }
    
    // Gera um alerta de confirmação do unfavorite
    func confirmDelete(_ categoryDelete: Movie) {
        let categoryDeleteTitle = categoryDelete
        let alert = UIAlertController(title: "Unfavorite", message: "Are you sure you want to unfavorite \(categoryDeleteTitle.title)?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteMovie)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteMovie)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Exclui e salva as alterações em arquivo
    func handleDeleteMovie(_ alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteMovieIndexPath {
            tableView.beginUpdates()
            
            
            MovieStore.sharedInstance.favoriteMovies.remove(at: indexPath.row)
            MovieStore.sharedInstance.saveMoviesToDisk(movies: MovieStore.sharedInstance.favoriteMovies)

            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            deleteMovieIndexPath = nil
            
            tableView.endUpdates()
        }
    }
    
    func cancelDeleteMovie(_ alertAction: UIAlertAction!) {
        deleteMovieIndexPath = nil
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Unfavorite"
    }
    
    
    
    
}
