//
//  GoalsModel.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation


struct CharacterResponse: Codable {
    var info: CharactersInfo
    var results: [Character]?
}

enum CharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
}

struct CharactersInfo: Codable {
    var pages: Int
}

struct Character: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var gender: CharacterGender?
}
