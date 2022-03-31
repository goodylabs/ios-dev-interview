//
//  CharactersDetailsViewModelTests.swift
//  ios-dev-interview-tests
//
//  Created by Adam Majczyk on 15/09/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import XCTest
import RxSwift
import Foundation

@testable import IOS_DEV_INTERVIEW

final class CharactersDetailsViewModelTests: XCTestCase {
    
    func testFetchCharacterShouldUpdateCharacter() {
        // Given
        let character = ResponseMock.character
        let service = CharacterServiceMock(character: character)
        let viewModel = CharacterDetailsViewModel(service: service, id: character.id!)
        // When
        viewModel.fetchCharacter()
        // Then
        XCTAssertNotNil(viewModel.character.value)
        XCTAssertEqual(viewModel.character.value!.id, character.id)
        XCTAssertEqual(viewModel.character.value!.name, character.name)
        XCTAssertEqual(viewModel.character.value!.status, character.status)
        XCTAssertEqual(viewModel.character.value!.species, character.species)
        XCTAssertEqual(viewModel.character.value!.image, character.image)
        XCTAssertEqual(viewModel.character.value!.gender, character.gender)
    }

}
