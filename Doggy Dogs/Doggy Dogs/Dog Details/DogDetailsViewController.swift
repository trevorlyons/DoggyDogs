//
//  DogDetailsViewController.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import UIKit
import Combine

private let EdgeInset: CGFloat = 5

class DogDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    
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
        // collectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = EdgeInset
        layout.minimumInteritemSpacing = EdgeInset
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cell: DogDetailsCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        // header setup
        headerLabel.text = viewModel.headerText
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
            // TODO: show alert for containing error
            print(error)
        }
    }
}

// MARK: - CollectionView FlowLayout Methods

extension DogDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: EdgeInset, left: EdgeInset, bottom: EdgeInset, right: EdgeInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = (collectionView.frame.width - ((layout?.minimumInteritemSpacing ?? EdgeInset) * 3)) / 2
        return CGSize(width: width, height: width)
    }
}

// MARK: - CollectionView DataSource Methods

extension DogDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: DogDetailsCollectionViewCell.self, indexPath: indexPath)
        let dogImage = viewModel.dogImages[indexPath.row]
        cell.configure(with: dogImage)
        return cell
    }
}
