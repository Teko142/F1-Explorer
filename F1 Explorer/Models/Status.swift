//
//  Status.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import Foundation

struct Status: Codable {
    let response: Response
}

struct Response: Codable {
    let requests: Requests
}

struct Requests: Codable {
    let current: Int
    let limit_day: Int
}
