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

class CharacterDetailsViewModel {

    private let service: CharacterService
    let characterToFetch = PublishSubject<Int>()
    let disposeBag = DisposeBag()

    let characterName = PublishSubject<String>()
    let characterSpecies = PublishSubject<String>()
    let characterStatus = PublishSubject<String>()
    let characterGender = PublishSubject<GenderType>()
    let characterImgUrl = PublishSubject<String>()


    init(service: CharacterService) {
        self.service = service
        self.performBindings()
    }

    func performBindings() {
        characterToFetch.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            self.service.getCharacter(charactedID: value).subscribe(onNext: { character in
                self.publishCharacter(character: character)
            }, onError: { error in
                print(error)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }


}

extension CharacterDetailsViewModel {
    func publishCharacter(character: Character) {
        if let name = character.name {
            characterName.onNext(name)
        }
        if let specie = character.species {
            characterSpecies.onNext(specie)
        }
        if let status = character.status {
            characterStatus.onNext(status)
        }
        if let gender = character.gender {
            switch gender.lowercased() {
            case "male":
                characterGender.onNext(.male)
            case "female":
                characterGender.onNext(.female)
            case "unknown":
                characterGender.onNext(.unknown)
            default:
                characterGender.onNext(.unknown)
            }
        }
        if let imgUrl = character.image {
            characterImgUrl.onNext(imgUrl)
        }
    }
}

enum GenderType {
    case male
    case female
    case unknown
}
