//
//  Album.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import Foundation

struct TopLevelAlbumDetail: Decodable {
    private enum CodingKeys: String, CodingKey {
        case topLevel = "results"
    }
    
    let topLevel: [AlbumDetail]
}

struct AlbumDetail: Decodable {
    private enum CodingKeys: String, CodingKey {
        case albumID = "collectionId"
        case albumName = "collectionName"
        case albumCoverArt = "artworkUrl100"
        case trackName
        case trackTime = "trackTimeMillis"
    }
    
    let albumID: Int
    let albumName: String
    let albumCoverArt: String
    let trackName: String
    let trackTime: Int
}
