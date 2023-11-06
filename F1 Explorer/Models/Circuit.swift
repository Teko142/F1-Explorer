//
//  CircuitsResponse.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 30/10/2023.
//

import Foundation

struct CircuitsResponse: Codable {
    let response: [Circuits]
}

struct Circuits: Codable {
    let id: Int
    let name: String?
    let image: String?
    let competition: Competition?
    let laps: Int?
    let length: String?
    let opened: Int?
}

struct Competition: Codable {
    let id: Int?
    let location: Location?
}

struct Location: Codable {
    let country: String?
    let city: String?
}
