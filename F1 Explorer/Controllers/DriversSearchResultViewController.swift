//
//  DriversSearchResultViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 01/11/2023.
//

import UIKit

class DriversSearchResultViewController: UIViewController {

    public var drivers: [Driver] = [Driver]()
    
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
        cell.configure(imageURL: driver.image ?? "", name: driver.name ?? "Unknown name", number: driver.number ?? 0, team: driver.teams?[0].team?.name ?? "Unknown team")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
}
