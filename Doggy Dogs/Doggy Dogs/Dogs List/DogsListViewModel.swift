//
//  DogsListViewModel.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation
import Combine

class DogsListViewModel: ObservableObject {
    
    enum State {
        case loading(Bool)
        case loaded
        case failure(Error)
    }
    
    @Published private(set) var state: State = .loading(true)
    private(set) lazy var dogs = [String]()
    private lazy var storage = Set<AnyCancellable>()
    private let repository: DogListRepositoryProtocol
    
    // MARK: Initialiser
    
    init(repository: DogListRepositoryProtocol = DogListRepository()) {
        self.repository = repository
    }
    
    // MARK: Public Methods
    
    func loadDogs() {
        state = .loading(true)
        repository.getDogs()
            .sink { [weak self] completion in
                self?.state = .loading(false)
                switch completion {
                case .failure(let error):
                    self?.state = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] dogs in
                self?.dogs = dogs
                self?.state = .loaded
            }
            .store(in: &storage)
    }
}
