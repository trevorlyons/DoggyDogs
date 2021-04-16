//
//  DogDetailsViewModel.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

class DogDetailsViewModel: ObservableObject {
    
    enum State {
        case loading(Bool)
        case loaded
        case failure(Error)
    }
    
    @Published private(set) var state: State = .loading(true)
    private(set) lazy var dogImages = [String]()
    private lazy var storage = Set<AnyCancellable>()
    private let repository: DogDetailsRepositoryProtocol
    private let breed: String
    
    var headerText: String { "What lovely \(breed)s" }
    
    // MARK: Initialiser
    
    init(repository: DogDetailsRepositoryProtocol = DogDetailsRepository(), breed: String) {
        self.repository = repository
        self.breed = breed
    }
    
    // MARK: Public Methods
    
    func loadBreedImages() {
        self.state = .loading(true)
        repository.getDogDetails(for: breed)
            .sink { [weak self] completion in
                self?.state = .loading(false)
                switch completion {
                case .failure(let error):
                    self?.state = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] dogImages in
                self?.dogImages = dogImages
                self?.state = .loaded
            }
            .store(in: &storage)
    }
}
