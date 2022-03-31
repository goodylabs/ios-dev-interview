//
//  CharacterResource.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import Moya

enum CharacterResource: TargetType {
    
    case getCharacters(page: Int)
    case getCharacter(Int)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character/"
        case .getCharacter(let id):
            return "/character/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacters, .getCharacter:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return getHeaders()
    }
    
    var task: Task {
        switch self {
        case .getCharacters(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .getCharacter:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
}
