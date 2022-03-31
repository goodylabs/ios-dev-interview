//
//  CharacterService.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol CharacterService {
    func getCharacters(page: Int) -> Observable<CharacterResponse>
    func getCharacter(id: Int) -> Observable<Character>
}

class CharacterServiceImpl: BaseApiService<CharacterResource>, CharacterService {
    
    static var shared = CharacterServiceImpl()
    
    func getCharacters(page: Int) -> Observable<CharacterResponse> {
        return request(for: .getCharacters(page: page))
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
}
