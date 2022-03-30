//
//  CharacterServiceMocks.swift
//  ios-dev-interview-tests
//
//  Created by Kacper Trębacz on 29/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift

@testable import IOS_DEV_INTERVIEW

final class CharacterServiceMocks: CharacterService {
    var isSuccessful = false
    var didRequest = false

    func getCharacters(page: Int) -> Observable<CharacterResponse> {
        didRequest = true
        if isSuccessful {
            return .just(MockResponse.characters)
        } else {
            return .error(ServiceError.error)
        }
    }

    func getCharacter(charactedID: Int) -> Observable<Character> {
        didRequest = true
        if isSuccessful {
            return .just(MockResponse.character)
        } else {
            return .error(ServiceError.error)
        }
    }
}

enum ServiceError: String, Error {
    case error = "service error"
}
