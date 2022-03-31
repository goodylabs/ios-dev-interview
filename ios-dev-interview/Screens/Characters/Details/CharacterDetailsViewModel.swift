//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Eryk Gasiorowski on 27/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CharactersDetailsViewModel: BaseViewModel {
    
    var onSuccess = PublishSubject<(CharacterDetailsView.Model)>()
    var onError = PublishSubject<String>()
    
    var genderImage: String = ""
    private let characterID: Int
    private let service: CharacterService
    
    init(characterID: Int,
         service: CharacterService = CharacterServiceImpl()) {
        self.characterID = characterID
        self.service = service
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        service.getCharacter(id: characterID)
            .subscribe(onNext: { result in
                let model = CharacterDetailsView.Model(characterName: result.name ?? "", statusState: result.status ?? "", speciesName: result.species ?? "", avatarImage: result.image ?? "", genderImage: self.getGenderImage(for: result.gender))
                
                self.onSuccess.onNext(model)
            }, onError: { [weak self] error in
                self?.onError.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func getGenderImage(for genderName: String?) -> UIImage? {
        guard let genderName = genderName else { return nil }
        
        switch genderName {
        case "Male":
            return UIImage(named: "Male")
        case "Female":
            return UIImage(named: "Female")
        case "Genderless":
            return UIImage(named: "Genderless")
        case "unknown":
            return UIImage(systemName: "questionmark.app")
        default:
            return UIImage(systemName: "person.crop.square")
        }
    }
}

