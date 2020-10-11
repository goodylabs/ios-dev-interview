//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Tomek Rybkowski on 11/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

class CharacterDetailsViewModel: BaseViewModel {
    
    private let service: CharacterService
    
    let character = BehaviorRelay<Character>(value: Character())
    
    let characterId: Int
    
    init(service: CharacterService, characterId: Int) {
        self.service = service
        self.characterId = characterId
    }
    
    func fetchCharacter() {
        service.getCharacter(id: characterId)
            .subscribe(onNext: { res in
                self.character.accept(res)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
