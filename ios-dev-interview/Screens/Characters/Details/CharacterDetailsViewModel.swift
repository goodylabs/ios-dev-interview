//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Marcin Pałosz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterDetailsViewModel: BaseViewModel {
    
    let character = BehaviorRelay<Character?>(value: nil)
    
    private let service: CharacterService
    private let id: Int
    
    init(service: CharacterService, id: Int) {
        self.service = service
        self.id = id
    }
    
    func fetchCharacter() {
        service.getCharacter(id: id)
            .subscribe(onNext: { res in
                self.character.accept(res)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
