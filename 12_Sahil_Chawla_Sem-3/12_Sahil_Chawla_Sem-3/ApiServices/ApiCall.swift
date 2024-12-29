//
//  ApiCall.swift
//  SegmentWithApi
//
//  Created by Hiren Masaliya on 03/12/24.
//

import Foundation
import Alamofire

class ApiCall {
    
    func JokeApi(cv:@escaping(Result<[JokeModel],Error>)->Void){
        
        let urlstr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlstr).responseDecodable(of: [JokeModel].self) { response in
            switch response.result {
            case .success(let data):
                cv(.success(data))
            case .failure(let error):
                cv(.failure(error))
            }
        }
        
    }
}
