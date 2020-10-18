//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Kacper Wysocki on 17/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterDetailsViewModel: BaseViewModel {
    
    private let service: CharacterService
    
    let character = BehaviorRelay<Character>(value: Character())
    let characterId: Int
    
    init(service: CharacterService, characterId: Int) {
        self.service = service
        self.characterId = characterId
    }
    
    func fetchCharacters() {
        service.getCharacterDetails(id: characterId)
            .subscribe { [weak self] (character) in
                guard let self = self else { return }
                self.character.accept(character)
            } onError: { (error) in
                print(error)
            }.disposed(by: disposeBag)
    }
}
