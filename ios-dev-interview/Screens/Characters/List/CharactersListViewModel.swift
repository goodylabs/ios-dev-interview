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
    
    var characters = BehaviorRelay<[Character]>(value: [])
    var pages: Int = 0
    var nextPage: Int = 2
    var isFetchingNextPage: Bool = false
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func fetchCharacters() {
        service.getCharacters()
            .subscribe(onNext: { res in
                self.pages = res.info?.pages ?? 0
                self.characters.accept(res.results ?? [])    
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func fetchNextPage() {
        service.getCharactersNextPage(page: nextPage)
            .subscribe(onNext: { res in
                var list = self.characters.value
                list.append(contentsOf: res.results ?? [])
                
                self.characters.accept(list)
                self.isFetchingNextPage = false
                self.nextPage += 1
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
        navigateToDetails(characters.value[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.value.count - 3 {
            if(!isFetchingNextPage) {
                isFetchingNextPage = true
                fetchNextPage()
            }
        }
    }
}

