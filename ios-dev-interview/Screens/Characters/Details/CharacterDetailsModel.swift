//
//  CharacterDetailsModel.swift
//  ios-dev-interview
//
//  Created by Eryk Gasiorowski on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation

struct CharacterDetails: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var image: String?
    var gender: String?
}
