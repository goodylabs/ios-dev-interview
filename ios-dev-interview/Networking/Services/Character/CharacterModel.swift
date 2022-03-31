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

struct Character: Codable, Equatable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var gender: GenderType?
}

enum GenderType: String , Codable{
    case male
    case female
    case unknown

    private enum RawValues: String, Codable {
        case male = "male"
        case female = "female"
    }
}

extension GenderType {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringFromRawValues = try container.decode(String.self)
        switch stringFromRawValues.lowercased() {
        case RawValues.male.rawValue:
            self = .male
        case RawValues.female.rawValue:
            self = .female
        default:
            self = .unknown
        }
    }

}






