//
//  AlbumDetailViewController.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDetailTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumDetailTableView.dataSource = self
        updateUI()
        fetchAlbumDetails()
    }
    
    // MARK: - Properties
    var albums: Albums?
    var topLevelAlbumDict: TopLevelAlbumDetail?
    var albumDetailArray: [AlbumDetail] = []
    
    // MARK: - Functions
    
    func updateUI() {
        guard let album = albums else {return}
        NetworkingService.fetchAlbumDetailArt(forAlbum: album) { [weak self] result in
            switch result {

            case .success(let art):
                DispatchQueue.main.async {
                    self?.albumImageView.image = art
                    self?.albumNameLabel.text = album.albumName
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unkown Error")
            }
        }
    }
    
    func fetchAlbumDetails() {
        guard let albumDetails = albums else {return}
        NetworkingService.fetchAlbumDetails(forAlbum: albumDetails) { [weak self] result in
            switch result {
                
            case .success(let topLevel):
                self?.topLevelAlbumDict = topLevel
                self?.albumDetailArray.append(contentsOf: topLevel.topLevel)
                DispatchQueue.main.async {
                    self?.albumDetailTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unkown Error")
            }
        }
    }
} // end of class

// MARK: - Extension

extension AlbumDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let removeEmptyIndex = albumDetailArray.remove(at: 0)
        return albumDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        let albumArray = albumDetailArray[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = albumArray.trackName
        config.secondaryText = String(albumArray.trackTime ?? 0)
        cell.contentConfiguration = config
        
        return cell
    }
}
