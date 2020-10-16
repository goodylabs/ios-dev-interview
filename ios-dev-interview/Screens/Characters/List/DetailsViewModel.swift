//
//  DetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Vitalii on 16/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModel: BaseViewModel {
    
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
