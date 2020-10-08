//
//  GoalsResource.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 25/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import Moya

enum GoalsResource: TargetType {
    
    case getCharacters
    case getCharacter(Int)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
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
        case .getCharacters:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getCharacter:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
}
