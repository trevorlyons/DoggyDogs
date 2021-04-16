//
//  DogsListRepository.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

protocol DogListRepositoryProtocol {
    func getDogs() -> AnyPublisher<[String], Error>
}

struct DogListRepository: DogListRepositoryProtocol {
    
    func getDogs() -> AnyPublisher<[String], Error> {
        return DogService.getDogsList()
    }
}
