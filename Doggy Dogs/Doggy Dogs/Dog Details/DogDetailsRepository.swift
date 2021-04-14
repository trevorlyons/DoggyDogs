//
//  DogDetailsRepository.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

protocol DogDetailsRepositoryProtocol {
    func getDogs() -> AnyPublisher<DogDetailsModel, Error>
}

struct DogDetailsRepository: DogDetailsRepositoryProtocol {
    
    func getDogs() -> AnyPublisher<DogDetailsModel, Error> {
        // TODO: networking
        return AnyPublisher(Fail<DogDetailsModel, Error>(error: NSError()))
    }
}
