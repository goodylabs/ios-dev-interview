//
//  CharactersListViewModel.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 08/10/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CharactersListViewModel: BaseViewModel {
    
    private let service: CharacterService
    
    let characters = BehaviorRelay<[Character]>(value: [])
    var error = BehaviorRelay<Error?>(value: nil)

    var page = PublishRelay<Int>()
    var pageCounter = 1

    init(service: CharacterService) {
        self.service = service
        super.init()
        self.pageBinding()
    }

    func pageBinding() {
        let newCharacters = page.flatMapLatest { [unowned self] value in
            self.service.getCharacters(page: value).catchError { err in
                return Observable.error(err)
            }
        }

        newCharacters.subscribe(onNext: { [weak self] characters in
            guard let self = self else { return }
            guard let characters = characters.results else { return }
            self.characters.accept(self.characters.value + characters)
        },onError: { [weak self] err in
            self?.error.accept(err)
        }).disposed(by: disposeBag)
    }

    func navigateToDetails(_ characterId: Int?) {
        if let id = characterId {
            AppNavigator.shared.navigate(to: CharactersRoutes.details(id), with: .push)
        }
    }
}

extension CharactersListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: CharacterCell.self), for: indexPath) as? CharacterCell
        else {
            return UITableViewCell()
        }

        if characters.value.count <= indexPath.row {
            return cell
        }
        let item = characters.value[indexPath.row]
        cell.setup(character: item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetails(characters.value[indexPath.row].id)
    }
}

extension CharactersListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.value.count - 1 {
            pageCounter += 1
            page.accept(pageCounter)
        }
    }
}


