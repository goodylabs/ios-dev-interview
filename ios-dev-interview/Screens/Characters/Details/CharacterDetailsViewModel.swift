//
//  CharacterDetailsViewModel.swift
//  ios-dev-interview
//
//  Created by Marcin Pałosz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation

final class CharacterDetailsViewModel: BaseViewModel {
    
    private let service: CharacterService
    private let id: Int
    
    init(service: CharacterService, id: Int) {
        self.service = service
        self.id = id
    }
    
}
