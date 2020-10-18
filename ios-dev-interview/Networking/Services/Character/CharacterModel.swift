//
//  GoalsModel.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
    
    enum CodingKeys: CodingKey {
        case gender
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let stingValue = try container.decode(String.self)
            self.init(value: stingValue)
        } catch  {
            self = .unknown
        }
    }
    
    private init(value: String) {
        self = CharacterGender(rawValue: value) ?? .unknown
    }
}

struct CharacterResponse: Codable {
    var results: [Character]?
}

struct Character: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var gender: CharacterGender?
}
