//
//  PageModel.swift
//  ios-dev-interview
//
//  Created by Eryk Gasiorowski on 31/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation

struct Pages: Codable {
    var count: Int?
    var pages: Int
    var next: String?
    var prev: String?
}
