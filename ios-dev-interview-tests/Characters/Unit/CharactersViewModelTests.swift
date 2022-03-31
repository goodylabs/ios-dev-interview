//
//  CharactersViewModelTests.swift
//  ios-dev-interview-tests
//
//  Created by Adam Majczyk on 15/09/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import IOS_DEV_INTERVIEW

struct CharacterServiceMock: CharacterService {
    
    func getCharacters(page: Int) -> Observable<CharacterResponse> { characters }

    func getCharacter(id: Int) -> Observable<Character> { character }
    
    let characters: Observable<CharacterResponse>
    let character: Observable<Character>
    
    init(characters: Observable<CharacterResponse>? = nil, character: Observable<Character>? = nil) {
        self.characters = characters ?? Observable.just(CharacterResponse(info: .init(pages: 0)))
        self.character = character ?? Observable.just(Character())
    }

}

class CharactersViewModelTests: XCTestCase {
    func testFetchCharacterShouldUpdateCharacter() {
        // Given
        let character = Observable.just(Character(id: 5, name: "Marcin"))
        let service = CharacterServiceMock(character: character)
        let viewModel = CharacterDetailsViewModel(service: service, id: 5)
        // When
        viewModel.fetchCharacter()
        // Then
        //I would check if character id and name are equal to viewModel.character id and name by using XCTAssert
    }
    
    func testFetchCharactersListShouldUpdateCharacters() {
        // Given
        let characters = Observable.just(CharacterResponse(info: .init(pages: 0), results: [Character(id: 5, name: "Marcin"), Character(id: 7, name: "Jacek")]))
        let service = CharacterServiceMock(characters: characters)
        let viewModel = CharactersListViewModel(service: service)
        // When
        viewModel.fetchCharacters(page: 0)
        //Then
        //I would check if both characters id and name are equal to viewModel.characters id and name by using XCTAssert
    }
}
