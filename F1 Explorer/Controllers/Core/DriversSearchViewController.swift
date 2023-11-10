//
//  DriversSearchViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit

class DriversSearchViewController: UIViewController {

    public var savedDrivers: [DriverItem] = [DriverItem]()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: DriversSearchResultViewController())
        controller.searchBar.placeholder = "Search for a Driver"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
            
    public let driversTable: UITableView = {
        let table = UITableView()
        table.register(DriverTableViewCell.self, forCellReuseIdentifier: DriverTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Drivers Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(driversTable)
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        
        driversTable.delegate = self
        driversTable.dataSource = self
        
        fetchLocalStorageForSaves()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("saved"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForSaves()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        driversTable.frame = view.bounds
    }
    
    private func fetchLocalStorageForSaves() {
        DataPersistenceManager.shared.fetchingDriversFromDatabase { [weak self] result in
            switch result {
            case .success(let drivers):
                self?.savedDrivers = drivers
                DispatchQueue.main.async {
                    self?.driversTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



extension DriversSearchViewController: UISearchResultsUpdating, DriversSearchResultViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedDrivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.identifier, for: indexPath) as? DriverTableViewCell else {
            return UITableViewCell()
        }
        let driver = savedDrivers[indexPath.row]
        cell.configure(imageURL: driver.image ?? "", name: driver.name ?? "Unknown name", number: Int(driver.number), team: driver.teamName ?? "Unknown team")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let driver = savedDrivers[indexPath.row]
        let vc = DriverDetailViewController()
        vc.configure(with: DriverDetailViewModel(id: Int(driver.id), name: driver.name ?? "Unknown Name", image: driver.image ?? "", country: driver.countryName ?? "Unknown Country", birthDate: driver.birthdate ?? "Unknown Birthday", number: Int(driver.number), worldChampionships: Int(driver.world_championships), podiums: Int(driver.podiums), driverTeamName: driver.teamName ?? "Unknown Team", driverTeamLogo: driver.logo ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteDriverWith(model: savedDrivers[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("deleted from DataBase")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.savedDrivers.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultController = searchController.searchResultsController as? DriversSearchResultViewController else {return}
        resultController.delegate = self
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
    
    func driversSearchResultViewControllerDidTapItem(_ viewModel: DriverDetailViewModel) {
        DispatchQueue.main.async {
            let vc = DriverDetailViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
}
