//
//  CharactersRoutes.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 08/10/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//
import UIKit

enum CharactersRoutes: Route {
    case list
    case details(Int)
    
    var screen: UIViewController {
        switch self {
        case .list:
            return buildCharactersListViewController()
        case .details(let characterId):
            return buildCharactersDetailsViewController(characterId)
        }
    }
    
    private func buildCharactersListViewController() -> UIViewController {
        let controller = CharactersListViewController()
        controller.viewModel = CharactersListViewModel(service: CharacterServiceImpl.shared)
        return controller
    }
    
    private func buildCharactersDetailsViewController(_ characterId: Int) -> UIViewController {
        let controller = CharacterDetailsViewController()
        controller.characterDetailsVM = CharacterDetailsViewModel(service: CharacterServiceImpl.shared)
        controller.characterDetailsVM.characterToFetch.onNext(characterId)
        return controller
    }
}

