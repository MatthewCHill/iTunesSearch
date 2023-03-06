//
//  NetwrokService.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import UIKit

class NetworkingService {
    
    static func fetchAlbums(forArtist search: String, completion: @escaping (Result<TopLevelResults, NetworkError>) -> Void) {
        
        //https://itunes.apple.com/search?entity=album&limit=25&term=Circa%20Survive
        guard let baseURL = URL(string: Constants.ItunesURL.baseURL) else {completion(.failure(.invalidURL)); return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.ItunesURL.searchPath)
        
        let albumQuery = URLQueryItem(name: Constants.QueryItems.queryEntityKey, value: Constants.QueryItems.queryEntityAlbumValue)
        let limitQuery = URLQueryItem(name: Constants.QueryItems.queryLimitKey, value: Constants.QueryItems.queryLimitValue)
        let artistQuery = URLQueryItem(name: Constants.QueryItems.queryArtistKey, value: search)
        urlComponents?.queryItems = [albumQuery, limitQuery, artistQuery]
        
        guard let finalURL = urlComponents?.url else {completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {completion(.failure(.noData)); return}
            
            do {
                let topLevel = try JSONDecoder().decode(TopLevelResults.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchAlbumArt(forAlbum album: Albums, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let finalURL = URL(string: album.albumArt) else {completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {completion(.failure(.noData)); return}
            guard let image = UIImage(data: data) else {completion(.failure(.unableToDecode)); return}
            completion(.success(image))
        }.resume()
        
    }
    
    static func fetchAlbumDetails(forAlbum album: Albums, completion: @escaping (Result<TopLevelAlbumDetail, NetworkError>) -> Void) {
        //https://itunes.apple.com/lookup?entity=song&id=493465268
        guard let baseURL = URL(string: Constants.ItunesURL.baseURL) else { completion(.failure(.invalidURL)); return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.ItunesURL.lookupPath)
        
        let entityQuery = URLQueryItem(name: Constants.QueryItems.queryEntityKey, value: Constants.QueryItems.queryEntitySongValue)
        let idQuery = URLQueryItem(name: Constants.QueryItems.queryIdKey, value: String(album.albumID))
        urlComponents?.queryItems = [entityQuery, idQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data , response , error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {completion(.failure(.noData)); return}
            
            do {
                let topLevel = try JSONDecoder().decode(TopLevelAlbumDetail.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    
    static func fetchAlbumDetailArt(forAlbum album: Albums, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let finalURL = URL(string: album.albumArt) else {completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {completion(.failure(.noData)); return}
            guard let image = UIImage(data: data) else {completion(.failure(.unableToDecode)); return}
            completion(.success(image))
        }.resume()
        
    }
    
}
