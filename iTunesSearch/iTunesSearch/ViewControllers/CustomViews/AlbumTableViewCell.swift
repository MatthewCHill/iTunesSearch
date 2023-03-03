//
//  AlbumTableViewCell.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    
    // MARK: - Functions
    
    func fetchArtistAlbums(forArtist album: Albums) {
        albumNameLabel.text = album.albumName
        trackCountLabel.text = "Tracks: \(album.trackCount)"
        NetworkingService.fetchAlbumArt(forAlbum: album) { [weak self] result in
            switch result {
                
            case .success(let albumArt):
                DispatchQueue.main.async {
                    self?.albumArtImageView.image = albumArt
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
    }
}
