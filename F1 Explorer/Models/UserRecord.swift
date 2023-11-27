//
//  UserRecord.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 21/11/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct UserRecord: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var location: String
    var record: Double
}
