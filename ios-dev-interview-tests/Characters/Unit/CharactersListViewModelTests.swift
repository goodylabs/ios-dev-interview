//
//  CharactersListViewModelTests.swift
//  ios-dev-interview-tests
//
//  Created by Marcin Pałosz on 31/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import XCTest
import RxSwift
import Foundation

@testable import IOS_DEV_INTERVIEW

final class CharactersListViewModelTests: XCTestCase {

    func testFetchCharactersListShouldUpdateCharacters() {
        // Given
        let characters = ResponseMock.characters
        let service = CharacterServiceMock(characters: characters)
        let viewModel = CharactersListViewModel(service: service)
        // When
        viewModel.fetchCharacters(page: 0)
        // Then
        XCTAssertEqual(viewModel.characters.value[0].id, characters.results![0].id)
        XCTAssertEqual(viewModel.characters.value[0].name, characters.results![0].name)
        XCTAssertEqual(viewModel.characters.value[1].id, characters.results![1].id)
        XCTAssertEqual(viewModel.characters.value[1].name, characters.results![1].name)
        // Analogically we could test other fields
    }

}
