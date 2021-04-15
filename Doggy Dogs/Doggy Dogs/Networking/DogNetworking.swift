//
//  DogNetworking.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

enum DogNetworkError: Error {
    case invalidUrl
    case responseError(String?)
}

extension DogNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "This url is a bit doggy..."
        case .responseError(let message):
            return message
        }
    }
}

class DogNetworking {
    
    static func perform<T: Decodable>(with url: String, model: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return AnyPublisher(Fail<T, Error>(error: DogNetworkError.invalidUrl))
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
