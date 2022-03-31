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
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func fetchCharacters() {
        service.getCharacters()
            .subscribe(onNext: { res in
                self.characters.accept(res.results ?? [])
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func navigateToDetails(_ characterId: Int?){
        if let id = characterId {
            AppNavigator.shared.navigate(to: CharactersRoutes.details(id), with: .push)
        }
    }
}

extension CharactersListViewModel: UITableViewDataSource, UITableViewDelegate {
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
        
        cell.button.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToDetails(item.id)
            }).disposed(by: disposeBag)
        cell.setup(character: item)
        
        return cell
    }
}



