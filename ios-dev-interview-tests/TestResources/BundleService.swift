//
//  BundleService.swift
//  ios-dev-interview-tests
//
//  Created by Adam Majczyk on 15/09/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import Foundation

class BundleService {
    static var shared = BundleService()
    
    func getBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
}
