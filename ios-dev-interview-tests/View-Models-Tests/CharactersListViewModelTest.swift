
//  CharactersViewModelTests.swift
//  ios-dev-interview-tests
//
//  Created by Adam Majczyk on 15/09/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxRelay

@testable import IOS_DEV_INTERVIEW

class CharactersListViewModelTests: XCTestCase {

    var service: CharacterServiceMocks!
    var viewModel: CharactersListViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        service = CharacterServiceMocks()
        viewModel = CharactersListViewModel(service: service)
        disposeBag = DisposeBag()
        scheduler = .init(initialClock: 0)
    }

    func test_get_characters_successful() {
        service.isSuccessful = true
        XCTAssertFalse(service.didRequest)
        XCTAssertNil(viewModel.error.value)
        viewModel.page.accept(1)
        XCTAssertNotNil(viewModel.characters.value)
        XCTAssertNil(viewModel.error.value)
        XCTAssertTrue(service.didRequest)
    }

    func test_get_characters_fail() {
        service.isSuccessful = false
        XCTAssertFalse(service.didRequest)
        XCTAssertNil(viewModel.error.value)
        viewModel.page.accept(1)
        XCTAssertNotNil(viewModel.error.value)
        XCTAssertTrue(service.didRequest)
    }

    func test_get_characters_successful_RxTest() {
        service.isSuccessful = true
        let observer = scheduler.createObserver([Character]?.self)
        viewModel.characters.bind(to: observer).disposed(by: disposeBag)
        simulateScrolling(times: 100, 200)
        scheduler.start()
        XCTAssertEqual(observer.events, [
            Recorded.next(0, []),
            Recorded.next(100, MockResponse.characters.results),
            Recorded.next(200, MockResponse.characters.results! + MockResponse.characters.results!),
        ])
    }

    func test_get_characters_fail_RxSwift() {
        service.isSuccessful = false
        let observer = scheduler.createObserver(Error?.self)
        viewModel.error.bind(to: observer).disposed(by: disposeBag)
        simulateScrolling(times: 100, 200)
        scheduler.start()
        XCTAssertNotNil(viewModel.error.value)
    }

    func simulateScrolling(times: Int...) {
        let events: [Recorded<Event<Int>>] = times.map { Recorded.next($0, 1) }
        let scrolled = scheduler.createColdObservable(events)
        scrolled.bind(to: viewModel.page).disposed(by: disposeBag)
    }

    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
        service = nil
    }
}

