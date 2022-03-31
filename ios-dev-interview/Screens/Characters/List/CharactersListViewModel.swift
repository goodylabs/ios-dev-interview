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
    
    private var currentPage: Int = 1 {
        didSet {
            fetchCharacters(page: currentPage)
        }
    }
    
    private var totalPages: Int = 0
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func fetchCharacters(page: Int = 1) {
        service.getCharacters(page: page)
            .subscribe(onNext: { res in
                self.totalPages = res.info.pages
                self.characters.accept(self.characters.value + (res.results ?? []))
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
    
}

extension CharactersListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = characters.value[indexPath.row]
        navigateToDetails(item.id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = characters.value.count - 1
        if indexPath.row == lastItem {
            if currentPage < totalPages {
                currentPage += 1
            }
        }
    }
}

