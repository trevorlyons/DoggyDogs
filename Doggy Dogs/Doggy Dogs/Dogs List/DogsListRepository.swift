//
//  DogsListRepository.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

protocol DogListRepositoryProtocol {
    func getDogs() -> AnyPublisher<DogsListModel, Error>
}

struct DogListRepository: DogListRepositoryProtocol {
    
    func getDogs() -> AnyPublisher<DogsListModel, Error> {
        // TODO: networking
        return AnyPublisher(Fail<DogsListModel, Error>(error: NSError()))
    }
}
