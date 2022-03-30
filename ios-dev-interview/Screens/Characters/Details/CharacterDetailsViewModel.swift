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
    let characterToFetch = PublishSubject<Int>()
    let disposeBag = DisposeBag()
    let error = BehaviorRelay<Error?>(value: nil)

    let characterName = BehaviorRelay<String?>(value: nil)
    let characterSpecies = BehaviorRelay<String?>(value: nil)
    let characterStatus = BehaviorRelay<String?>(value: nil)
    let characterGender = BehaviorRelay<GenderType?>(value: nil)
    let characterImgUrl = BehaviorRelay<String?>(value: nil)

    init(service: CharacterService) {
        self.service = service
        self.performBindings()
    }

    func performBindings() {
        characterToFetch.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            self.service.getCharacter(charactedID: value).subscribe(onNext: { character in
                self.publishCharacter(character: character)
            }, onError: { [weak self] error in
                self?.error.accept(error)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }

}

extension CharacterDetailsViewModel {
    func publishCharacter(character: Character) {
        if let name = character.name {
            characterName.accept(name)
        }

        if let specie = character.species {
            characterSpecies.accept(specie)
        }
        if let status = character.status {
            characterStatus.accept(status)
        }
        if let gender = character.gender {
            switch gender.lowercased() {
            case "male":
                characterGender.accept(.male)
            case "female":
                characterGender.accept(.female)
            case "unknown":
                characterGender.accept(.unknown)
            default:
                characterGender.accept(.unknown)
            }
        }
        if let imgUrl = character.image {
            characterImgUrl.accept(imgUrl)
        }
    }
}

enum GenderType {
    case male
    case female
    case unknown
}
