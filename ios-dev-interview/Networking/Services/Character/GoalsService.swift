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

protocol CharacterService {
    func getCharacters() -> Observable<CharacterResponse>
    func getCharacter(id: Int) -> Observable<Character>
    func getCharactersNextPage(page: Int) -> Observable<CharacterResponse>
}

class CharacterServiceImpl: BaseApiService<GoalsResource>, CharacterService {
    
    static var shared = CharacterServiceImpl()
    
    func getCharacters() -> Observable<CharacterResponse> {
        return request(for: .getCharacters)
            .map {(items: CharacterResponse, _ response: Response) in
                return items
        }
    }
    
    func getCharacter(id: Int) -> Observable<Character> {
        return request(for: .getCharacter(id))
            .map {(item: Character, _ response: Response) in
                return item
        }
    }
    
    func getCharactersNextPage(page: Int) -> Observable<CharacterResponse> {
        return request(for: .nextPage(page))
            .map {(items: CharacterResponse, _ response: Response) in
                return items
        }
    }
}
