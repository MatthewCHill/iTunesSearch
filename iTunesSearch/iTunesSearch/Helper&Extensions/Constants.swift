//
//  Constants.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import Foundation

struct Constants {
    //https://itunes.apple.com/search?entity=album&limit=25&term=Circa%20Survive for albums by artist
    //https://itunes.apple.com/lookup?entity=song&id=493465268 for album detail
    struct ItunesURL {
        static let baseURL = "https://itunes.apple.com"
        static let searchPath = "/search"
        static let lookupPath = "/lookup"
    }
    
    struct QueryItems {
        static let queryEntityKey = "entity"
        static let queryEntityAlbumValue = "album"
        static let queryEntitySongValue = "song"
        
        static let queryIdKey = "id"
        
        static let queryLimitKey = "limit"
        static let queryLimitValue = "25"
        static let queryArtistKey = "term"
    }
}
