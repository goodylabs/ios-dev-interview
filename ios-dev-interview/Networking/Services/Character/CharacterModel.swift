//
//  GoalsModel.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation


struct CharacterResponse: Codable {
    var results: [Character]?
}

struct Character: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var gender: String?
}
