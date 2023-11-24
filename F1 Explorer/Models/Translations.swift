//
//  Translate.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 20/11/2023.
//

import Foundation

// MARK: - Welcome
struct TranslationResponse: Codable {
    let data: TranslationData
}

// MARK: - DataClass
struct TranslationData: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
