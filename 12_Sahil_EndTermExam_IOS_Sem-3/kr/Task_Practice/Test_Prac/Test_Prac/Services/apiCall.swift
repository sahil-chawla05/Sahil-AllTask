//
//  apiCall.swift
//  Test_Prac
//
//  Created by admin on 03/10/24.
//

import Foundation
import Alamofire

class apiCall{
    
    func fetchedData(completionHandler:@escaping((Result<[JokeModel],Error>) -> Void)){
        
        let urlStr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlStr).responseDecodable(of:[JokeModel].self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
