//
//  DogDetailsRepository.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

protocol DogDetailsRepositoryProtocol {
    func getDogDetails(for breed: String) -> AnyPublisher<DogDetailsModel, Error>
}

struct DogDetailsRepository: DogDetailsRepositoryProtocol {
    
    func getDogDetails(for breed: String) -> AnyPublisher<DogDetailsModel, Error> {
        return DogService.getDogDetails(for: breed)
    }
}
