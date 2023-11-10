//
//  TeamsViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit

class TeamsViewController: UIViewController {
    
    private var teams: [Team] = [Team]()
    
    private let teamsTable: UITableView = {
        let table = UITableView()
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Teams"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(teamsTable)
        
        teamsTable.delegate = self
        teamsTable.dataSource = self
        
        fetchTeams()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        teamsTable.frame = view.bounds
    }
    
    private func fetchTeams() {
        APICaller.shared.getTeams { [weak self] result in
            switch result {
            case .success(let teams):
                self?.teams = teams
                DispatchQueue.main.async {
                    self?.teamsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        let team = teams[indexPath.row]
        cell.configure(imageURL: team.logo ?? "", name: team.name ?? "Unknown team", base: team.base ?? "Unknown location")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        let vc = TeamDetailViewController()
        vc.configure(logo: team.logo ?? "", name: team.name ?? "Unknown Team", location: team.base ?? "Unknown base", president: team.president ?? "Unkown President", firstEntry: team.first_team_entry ?? 0, championships: team.world_championships ?? 0, position: team.highest_race_finish?.position ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}
