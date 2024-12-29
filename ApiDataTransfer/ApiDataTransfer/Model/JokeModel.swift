//
//  JokeModel.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import Foundation

struct JokeModel: Codable {
    let id: Int32
    let type: String
    let punchline: String
    let setup: String
}
