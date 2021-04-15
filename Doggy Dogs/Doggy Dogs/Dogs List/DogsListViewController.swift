//
//  DogsListViewController.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import UIKit
import Combine

class DogsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: DogsListViewModel
    private var cancellable: AnyCancellable?
    
    // MARK: - Initialisation
    
    init(viewModel: DogsListViewModel) {
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
        viewModel.loadDogs()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(cell: DogListTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    private func bind() {
        self.cancellable = self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state: state)
            }
    }
    
    private func render(state: DogsListViewModel.State) {
        switch state {
        case .loaded:
            self.tableView.reloadData()
        case .loading(let isLoading):
            // TODO: show and hide spinner for loading
            print(isLoading)
        case .failure(let error):
            // TODO: show alert for containing error
            print(error)
        }
    }
}

// MARK: - TableView Delegate Methods

extension DogsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // I would normally abstract my navigation but, as discussed in our previous call,
        // I normally use an internal framework for that. I am excited to play with coordinators
        // but I decided this may not be the time for that 🤝
        let breed = viewModel.dogs[indexPath.row]
        let viewModel = DogDetailsViewModel(breed: breed)
        let viewController = DogDetailsViewController(viewModel: viewModel)
        // For the sake of simplicity, I am just assuming that everyone in the world has ios 13+
        // and can dismiss this presented view with a gesture 🚀
        self.present(viewController, animated: true)
    }
}

// MARK: - TableView DataSource Methods

extension DogsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: DogListTableViewCell.self, indexPath: indexPath)
        let dog = viewModel.dogs[indexPath.row]
        cell.configure(with: dog)
        return cell
    }
}
