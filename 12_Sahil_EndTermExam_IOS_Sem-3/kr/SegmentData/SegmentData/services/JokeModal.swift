//
//  JokeModal.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//

import Foundation

struct JokeModal :Codable{
    var id : Int
    let punchline : String
    let setup : String
    let type : String
}

//struct JokeSaveModal :Codable{
//    var saveid = UUID()
//    var id : Int
//    let punchline : String
//    let setup : String
//    let type : String
//}

struct BookModal : Codable {
    var bookid = UUID()
    var bookname : String
    let bookauthor : String
    let bookisbn : Int
    let bookpage : Int
}
