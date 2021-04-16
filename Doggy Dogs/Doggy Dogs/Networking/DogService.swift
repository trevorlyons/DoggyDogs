//
//  DogService.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

// For both of these service methods I have checked the response for an error, and if
// one exists, have thrown an error so that the respective viewModels don't have to contain
// this logic. I was debating trying to create something generic that handles this for all
// calls if the status was `error` but thought that might be a bit much for this task. 💃
struct DogService {
    
    static func getDogsList() -> AnyPublisher<[String], Error> {
        let url = "https://dog.ceo/api/breeds/list/all"
        return DogNetworking.perform(with: url, model: DogsListModel.self)
            .tryMap {
                switch $0.status {
                case .success:
                    // To simplify this exercise I am only mapping the breeds and not
                    // the sub-breeds which would require a separate network call to
                    // get images for 🥲
                    return $0.data?.compactMap { $0.key } ?? []
                case .error:
                    throw DogNetworkError.responseError($0.errorMessage)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func getDogDetails(for breed: String) -> AnyPublisher<[String], Error> {
        let url = "https://dog.ceo/api/breed/\(breed)/images/random/10"
        return DogNetworking.perform(with: url, model: DogDetailsModel.self)
            .tryMap {
                switch $0.status {
                case .success:
                    return $0.dogImages ?? []
                case .error:
                    throw DogNetworkError.responseError($0.errorMessage)
                }
            }
            .eraseToAnyPublisher()
    }
}
