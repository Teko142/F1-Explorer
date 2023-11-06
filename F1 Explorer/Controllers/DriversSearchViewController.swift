//
//  DriversSearchViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit

class DriversSearchViewController: UIViewController {

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: DriversSearchResultViewController())
        controller.searchBar.placeholder = "Search for a Driver"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Drivers Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
}

extension DriversSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultController = searchController.searchResultsController as? DriversSearchResultViewController else {return}
        APICaller.shared.searchDrivers(with: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let drivers):
                    resultController.drivers = drivers
                    resultController.driversTable.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
