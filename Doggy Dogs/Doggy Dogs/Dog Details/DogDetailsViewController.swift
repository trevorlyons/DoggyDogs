//
//  DogDetailsViewController.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import UIKit
import Combine

class DogDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: DogDetailsViewModel
    private var cancellable: AnyCancellable?
    
    // MARK: - Initialisation
    
    init(viewModel: DogDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        viewModel.loadBreedImages()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        // TODO: add custom flowlayout
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    private func bind() {
        self.cancellable = self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state: state)
            }
    }
    
    private func render(state: DogDetailsViewModel.State) {
        switch state {
        case .loaded:
            self.collectionView.reloadData()
        case .loading(let isLoading):
            // TODO: show and hide spinner for loading
            print(isLoading)
        case .failure(let error):
            print(error)
            // TODO: show alert for containing error
        }
    }
}

// MARK: - CollectionView DataSource Methods

extension DogDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: custom cell
        return UICollectionViewCell()
    }
}
