//
//  DriversSearchResultViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 01/11/2023.
//

import UIKit

protocol DriversSearchResultViewControllerDelegate: AnyObject {
    func driversSearchResultViewControllerDidTapItem(_ viewModel: DriverDetailViewModel)
}

class DriversSearchResultViewController: UIViewController {

    public var drivers: [Driver] = [Driver]()
    
    public weak var delegate: DriversSearchResultViewControllerDelegate?
    
    public let driversTable: UITableView = {
        let table = UITableView()
        table.register(DriverTableViewCell.self, forCellReuseIdentifier: DriverTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(driversTable)
        
        driversTable.delegate = self
        driversTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        driversTable.frame = view.bounds
    }
}

extension DriversSearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.identifier, for: indexPath) as? DriverTableViewCell else {
            return UITableViewCell()
        }
        let driver = drivers[indexPath.row]
        let driverTeam: String
        if driver.teams?.count != 0 {
            driverTeam = driver.teams?[0].team?.name ?? "Unknown team"
        } else {
            driverTeam = "Unknown team"
        }
        cell.configure(imageURL: driver.image ?? "", name: driver.name ?? "Unknown name", number: driver.number ?? 0, team: driverTeam)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let driver = drivers[indexPath.row]
        let driverTeam: String
        let driverLogo: String
        if driver.teams?.count != 0 {
            driverTeam = driver.teams?[0].team?.name ?? "Unknown team"
        } else {
            driverTeam = "Unknown team"
        }
        if driver.teams?.count != 0 {
            driverLogo = driver.teams?[0].team?.logo ?? ""
        } else {
            driverLogo = ""
        }
        delegate?.driversSearchResultViewControllerDidTapItem(DriverDetailViewModel(id: driver.id, name: driver.name ?? "Unkown name", image: driver.image ?? "", country: driver.country?.name ?? "Unkown country", birthDate: driver.birthdate ?? "Unkown birthday", number: driver.number ?? 0, worldChampionships: driver.world_championships ?? 0, podiums: driver.podiums ?? 0, driverTeamName: driverTeam, driverTeamLogo: driverLogo))
    }
    
}
