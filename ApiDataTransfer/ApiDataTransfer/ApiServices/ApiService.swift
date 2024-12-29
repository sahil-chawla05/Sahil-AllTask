//
//  ApiService.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import Foundation
import Alamofire

class ApiService {
    
    func callJokeApi(cv: @escaping(Result<[JokeModel], Error>)->Void) {
        
        let urlStr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlStr).responseDecodable(of: [JokeModel].self) {
            response in switch response.result {
                case .success(let data) :
                    cv(.success(data))
                case .failure(let error) :
                    cv(.failure(error))
            }
         }
        
    }
    
}
