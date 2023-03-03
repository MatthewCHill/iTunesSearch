//
//  Constants.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import Foundation

struct Constants {
    //https://itunes.apple.com/search?entity=album&limit=25&term=Circa%20Survive
    struct ItunesURL {
        static let baseURL = "https://itunes.apple.com"
        static let searchPath = "/search"
    }
    
    struct QueryItems {
        static let queryAlbumKey = "entity"
        static let queryAlbumValue = "album"
        static let queryLimitKey = "limit"
        static let queryLimitValue = "25"
        static let queryArtistKey = "term"
    }
}
