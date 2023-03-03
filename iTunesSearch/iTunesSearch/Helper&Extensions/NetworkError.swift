//
//  NetworkError.swift
//  iTunesSearch
//
//  Created by Matthew Hill on 3/3/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case invalidStatusCode
    
    var errorDescription: String? {
        switch self{
            
        case .invalidURL:
            return "Invalid Url. Check URL endpoint."
        case .thrownError(let error):
            return "Thrown error. Error was \(error.localizedDescription)"
        case .noData:
            return "No data received from the network call."
        case .unableToDecode:
            return "Unable to decode model object from data."
        case .invalidStatusCode:
            return "Fetch returned an unsuccessful status code. Code was not 200."
        }
    }
}
