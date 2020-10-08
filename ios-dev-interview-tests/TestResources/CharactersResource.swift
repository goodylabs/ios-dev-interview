//
//  CharactersResource.swift
//  ios-dev-interview-tests
//
//  Created by Adam Majczyk on 15/09/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation
import Moya

enum CharactersResource: TargetType {
    
    case getCharacters
    
    var baseURL: URL {
        return URL(string: "https://www.google.com")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacters:
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
        }
    }
    
}
