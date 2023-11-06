//
//  Team.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 31/10/2023.
//

import Foundation

struct TeamsResponse: Codable {
    let response: [Team]
}

struct Team: Codable {
    let id: Int
    let name: String?
    let logo: String?
    let base: String?
    let first_team_entry: Int?
    let world_championships: Int?
    let highest_race_finish: BestRace?
    let president: String?
}

struct BestRace: Codable {
    let position: Int?
}
