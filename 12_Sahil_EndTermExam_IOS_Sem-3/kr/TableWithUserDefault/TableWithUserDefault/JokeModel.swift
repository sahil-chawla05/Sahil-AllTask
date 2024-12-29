//
//  JokeModel.swift
//  TableWithUserDefault
//
//  Created by admin on 03/10/24.
//

import Foundation

struct JokeModel : Codable{
    
    let id : Int
    let type : String
    let setup : String
    let punchline : String
}
