//
//  CharacterDetailsViewModelTest.swift
//  ios-dev-interview-tests
//
//  Created by Kacper Trębacz on 30/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxRelay

@testable import IOS_DEV_INTERVIEW

class CharacterDetailsViewModelTests: XCTestCase {

    var service: CharacterServiceMocks!
    var viewModel: CharacterDetailsViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        service = CharacterServiceMocks()
        viewModel = CharacterDetailsViewModel(service: service)
        disposeBag = DisposeBag()
    }

    func test_get_character_successful() {
        service.isSuccessful = true
        XCTAssertFalse(service.didRequest)
        viewModel.characterToFetch.onNext((1))
        XCTAssertNil(viewModel.error.value)
        XCTAssertEqual(viewModel.characterStatus.value, MockResponse.character.status)
        XCTAssertEqual(viewModel.characterName.value, MockResponse.character.name)
        XCTAssertEqual(viewModel.characterSpecies.value, MockResponse.character.species)
        XCTAssertEqual(viewModel.characterImgUrl.value, MockResponse.character.image)
        XCTAssertNotNil(viewModel.characterGender.value)
        XCTAssertTrue(service.didRequest)
   }

    func test_get_character_fail() {
        service.isSuccessful = false
        XCTAssertFalse(service.didRequest)
        XCTAssertNil(viewModel.error.value)
        viewModel.characterToFetch.onNext(1)
        XCTAssertNotNil(viewModel.error.value)
        XCTAssertTrue(service.didRequest)
    }

    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
        service = nil
    }
}

