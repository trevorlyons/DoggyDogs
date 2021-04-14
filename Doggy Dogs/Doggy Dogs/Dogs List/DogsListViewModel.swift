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
    private(set) lazy var dogs = [String: [String]]()
    private lazy var storage = Set<AnyCancellable>()
    private let repository: DogListRepositoryProtocol
    
    // MARK: Initialiser
    
    init(repository: DogListRepositoryProtocol = DogListRepository()) {
        self.repository = repository
    }
    
    // MARK: Public Methods
    
    func loadDogs() {

    }
}
