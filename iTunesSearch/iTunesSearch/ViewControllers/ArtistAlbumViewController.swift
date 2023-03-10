//
//  ArtistAlbumViewController.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import UIKit

class ArtistAlbumViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var artistSearchBar: UISearchBar!
    
    @IBOutlet weak var albumListTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumListTableView.dataSource = self
        artistSearchBar.delegate = self
    }
    
    // MARK: - Properties
    var topLevelAlbumDict: TopLevelResults?
    var albums: [Albums]?
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumDetail" {
            guard let index = albumListTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AlbumDetailViewController,
                  let albumToSend = albums?[index.row] else { return }
            destinationVC.albums = albumToSend
        }
    }
}

// MARK: - Extensions

extension ArtistAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        guard let album = albums?[indexPath.row] else { return UITableViewCell()}
        cell.fetchArtistAlbums(forArtist: album)
        
        return cell
    }
}

extension ArtistAlbumViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        NetworkingService.fetchAlbums(forArtist: searchTerm) { [weak self] result in
            switch result {
                
            case .success(let topLevel):
                self?.topLevelAlbumDict = topLevel
                self?.albums = topLevel.results
                DispatchQueue.main.async {
                    self?.albumListTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
    }
}
