//
//  AritistAlbum.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import Foundation

struct TopLevelResults: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [Albums]
}

struct Albums: Decodable {
    private enum CodingKeys: String, CodingKey {
        case albumID = "collectionId"
        case albumName = "collectionName"
        case trackCount
        case albumArt = "artworkUrl100"
    }
    let albumID: Int
    let albumName: String
    let trackCount: Int
    let albumArt: String
}
