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

class CharactersViewModelTests: XCTestCase {
    
    var viewModel: CharactersViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        viewModel = CharactersViewModel()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        disposeBag = nil
    }
    
    func testBottomText() {
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(true)
    }
    
}
