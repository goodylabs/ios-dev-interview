//
//  CharacterMoskResponse.swift
//  ios-dev-interview-tests
//
//  Created by Kacper Trębacz on 29/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
@testable import IOS_DEV_INTERVIEW

enum MockResponse {

    static let characters: CharacterResponse = .init(results: [
        Character(id: 1, name: "morty", status: "unknown", species: "human", image: nil, gender: .male),
        Character(id: 2, name: "Rick", status: "Alive", species: "human", image: nil, gender: .male)
    ])

    static let character = Character(id: 3, name: "Nick", status: "alive", species: "human", image: nil, gender: .female)
}
