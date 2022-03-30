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
        page.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            self.fetchCharacters(pageNumber: value)
        }).disposed(by: disposeBag)
    }

    func fetchCharacters(pageNumber: Int) {
        self.service.getCharacters(page: pageNumber)
            .subscribe(onNext: { [weak self] res in
                guard let self = self else { return}
                self.characters.accept(self.characters.value + (res.results ?? []))
            }, onError: { [weak self] error in
                self?.error.accept(error)
            }).disposed(by: self.disposeBag)
    }
    
    func navigateToDetails(_ characterId: Int?){
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


