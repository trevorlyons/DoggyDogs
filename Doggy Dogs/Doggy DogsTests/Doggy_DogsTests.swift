//
//  Doggy_DogsTests.swift
//  Doggy DogsTests
//
//  Created by Trevor Lyons on 14/04/2021.
//

import XCTest
import Combine
@testable import Doggy_Dogs

private let MockData = ["Fred", "Sally", "Joe"]

class Doggy_DogsTests: XCTestCase {

    var dogListViewModel: DogsListViewModel?
    var store: AnyCancellable?
    
    // MARK: - Setup/ TearDown

    override func setUpWithError() throws {
        // injecting the viewModel repository as `self` to allow the mocking of anything
        // that the repository contains, in this instance just the network call to get
        // the dogs list 🐕
        dogListViewModel = DogsListViewModel(repository: self)
    }

    override func tearDownWithError() throws {
        dogListViewModel = nil
        store = nil
    }

    // MARK: - Tests
    
    /// Tests that the downloaded data is locally set to the viewModels `dogs` property.
    /// Not the best test in the world but there wasn't a whole lot to pick from to show my
    /// appreciation for unit tests. 💃
    func testDogsLocallyStored() throws {
        let expectation = self.expectation(description: "Dogs")
        store = dogListViewModel?.$state.sink { state in
            switch state {
            case .loaded:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .loading:
                // breaking on the loading as it returns before .loaded and thus we would
                // not yet have the downloaded data locally stored.
                break
            }
        }
        // Calling the loadDogs after the binding is setup above so that it is ready
        // to receive the mock data
        dogListViewModel?.loadDogs()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(dogListViewModel?.dogs, MockData)
    }
}

// MARK: - Dog List Repository Mocking

extension Doggy_DogsTests: DogListRepositoryProtocol {
    
    func getDogs() -> AnyPublisher<[String], Error> {
        return Future<[String], Error> { promise in
            promise(.success(MockData))
        }.eraseToAnyPublisher()
    }
}
