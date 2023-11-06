//
//  Driver.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 01/11/2023.
//

import Foundation

struct DriversResponse: Codable {
    let response: [Driver]
}

struct Driver: Codable {
    let id: Int
    let name: String?
    let image: String?
    let country: Country?
    let birthdate: String?
    let number: Int?
    let worldChampionships: Int?
    let podiums: Int?
    let careerPoints: String?
    let teams: [DriverTeams]?
}

struct Country: Codable {
    let name: String?
}

struct DriverTeams: Codable {
    let season: Int?
    let team: TeamInfo?
}

struct TeamInfo: Codable {
    let id: Int?
    let name: String?
    let logo: String?
}

