//
//  JokeModel.swift
//  APIwithDependency
//
//  Created by admin on 21/09/24.
//

import Foundation

struct JokeModel : Codable{
    let id : Int
    let type : String
    let setup : String
    let punchline : String
}
