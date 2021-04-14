//
//  DogService.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

struct DogService {
    
    static func getDogsList() -> AnyPublisher<DogsListModel, Error> {
        let url = "https://dog.ceo/api/breeds/list/all"
        return DogNetworking.perform(with: url, model: DogsListModel.self)
    }
    
    static func getDogDetails(for breed: String) -> AnyPublisher<DogDetailsModel, Error> {
        let url = "https://dog.ceo/api/breed/\(breed)/images/random/10"
        return DogNetworking.perform(with: url, model: DogDetailsModel.self)
    }
}
