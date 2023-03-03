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
    var albums: [Albums] = []
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension ArtistAlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        let album = albums[indexPath.row]
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
                self?.albums.append(contentsOf: topLevel.results)
                DispatchQueue.main.async {
                    self?.albumListTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
    }
}
