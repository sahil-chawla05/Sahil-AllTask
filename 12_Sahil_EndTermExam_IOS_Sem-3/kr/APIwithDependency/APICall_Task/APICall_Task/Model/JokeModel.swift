//
//  JokeModel.swift
//  APICall_Task
//
//  Created by admin on 26/09/24.
//

import Foundation

struct JokeModel : Codable{
    let id : Int
    let type : String
    let setup : String
    let punchline : String
}
