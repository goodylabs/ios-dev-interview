//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Kacper Trębacz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher
import RxRelay

class CharacterDetailsViewModel {

    private let service: CharacterService
    let disposeBag = DisposeBag()
    let error = BehaviorRelay<Error?>(value: nil)
    let characterToFetch = PublishSubject<Int>()

    let characterName = BehaviorRelay<String?>(value: nil)
    let characterSpecies = BehaviorRelay<String?>(value: nil)
    let characterStatus = BehaviorRelay<String?>(value: nil)
    let characterGender = BehaviorRelay<GenderType?>(value: nil)
    let characterImgUrl = BehaviorRelay<String?>(value: nil)

    init(service: CharacterService) {
        self.service = service
        self.performBindings()
    }

    private func performBindings() {
        let devicesfromApi = characterToFetch.flatMapLatest { [unowned self] value in
            self.service.getCharacter(charactedID: value).catchError { err in
                return Observable.error(err)
            }
        }.share()

        devicesfromApi.subscribe(onNext: { [weak self] character in
            self?.characterName.accept(character.name)
            self?.characterGender.accept(character.gender)
            self?.characterStatus.accept(character.status)
            self?.characterSpecies.accept(character.species)
            self?.characterImgUrl.accept(character.image)
        },onError: { [weak self] err in
            self?.error.accept(err)
        }).disposed(by: disposeBag)
    }
}




