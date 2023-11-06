//
//  YouTubeSearchResponse.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 04/11/2023.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
