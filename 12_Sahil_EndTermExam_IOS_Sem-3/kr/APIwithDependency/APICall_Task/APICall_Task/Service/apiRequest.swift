//
//  apiRequest.swift
//  APICall_Task
//
//  Created by admin on 26/09/24.
//

import Foundation
import Alamofire

class APIClass {
    
    func apiFunc(completionHandler:@escaping(Result<[JokeModel],Error>) -> Void){
        
        let urlStr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlStr).responseDecodable(of : [JokeModel].self) { response in
            switch response.result{
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}