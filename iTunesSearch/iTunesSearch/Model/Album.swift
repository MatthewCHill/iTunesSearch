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
        case trackName
        case trackTime = "trackTimeMillis"
    }
    
    let albumID: Int?
    let trackName: String?
    let trackTime: Int?
}

extension AlbumDetail {
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.albumID = try? container?.decode(Int.self, forKey: .albumID)
        self.trackName = try? container?.decode(String.self, forKey: .trackName)
        self.trackTime = try? container?.decode(Int.self, forKey: .trackTime)
    }
}
