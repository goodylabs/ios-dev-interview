//
//  Mocks.swift
//  ios-dev-interview-tests
//
//  Created by Marcin Pałosz on 31/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
@testable import IOS_DEV_INTERVIEW

enum ResponseMock {
    static let characters = CharacterResponse(info: .init(pages: 0), results: [
        Character(id: 5, name: "Morty Smith", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: .male),
        Character(id: 8, name: "Arthricia", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: .female)
                  ])
        
    static let character = Character(id: 5, name: "Morty Smith", status: "Alive", species: "Alien", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: .male)
}

final class CharacterServiceMock: CharacterService {

    func getCharacters(page: Int) -> Observable<CharacterResponse> { characters }

    func getCharacter(id: Int) -> Observable<Character> { character }

    let characters: Observable<CharacterResponse>
    let character: Observable<Character>

    init(characters: CharacterResponse? = nil, character: Character? = nil) {
        self.characters = characters != nil ? Observable.just(characters!) : Observable.error(CharacterServiceError())
        self.character = character != nil ? Observable.just(character!) : Observable.error(CharacterServiceError())
    }
}

struct CharacterServiceError: Error { }
