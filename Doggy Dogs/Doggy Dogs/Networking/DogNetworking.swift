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
