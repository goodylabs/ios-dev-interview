//
//  GoalsService.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol CharacterService: AnyObject {
    func getCharacters(page: Int) -> Observable<CharacterResponse>
    func getCharacter(charactedID: Int) -> Observable<Character>
}

class CharacterServiceImpl: BaseApiService<GoalsResource>, CharacterService {
    
    static var shared = CharacterServiceImpl()
    
    func getCharacters(page: Int) -> Observable<CharacterResponse> {
        return request(for: .getCharacters(page))
            .map {(items: CharacterResponse, _ response: Response) in
                return items
        }
    }

    func getCharacter(charactedID: Int) -> Observable<Character> {
        return request(for: .getCharacter(charactedID))
            .map {(items: Character, _ response: Response) in
                return items
            }
    }
    
}

