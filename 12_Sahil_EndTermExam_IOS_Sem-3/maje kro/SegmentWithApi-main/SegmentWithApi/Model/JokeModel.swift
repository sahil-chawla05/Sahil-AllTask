//
//  JokeModel.swift
//  SegmentWithApi
//
//  Created by Hiren Masaliya on 03/12/24.
//

import Foundation

struct JokeModel : Codable{
    var id : Int32
    var type : String
    var setup : String
    var punchline : String
}
