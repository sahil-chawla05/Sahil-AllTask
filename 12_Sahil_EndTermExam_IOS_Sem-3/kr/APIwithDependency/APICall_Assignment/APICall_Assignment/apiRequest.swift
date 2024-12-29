//
//  apiRequest.swift
//  APICall_Assignment
//
//  Created by admin on 26/09/24.
//

import Foundation
import Alamofire

class APICall{
    
    func dataRequest(completionHandler: @escaping(Result<[DataModel],Error>) -> Void, paramUrl : String){
        
        let urlStr = "https://official-joke-api.appspot.com/jokes/random/25"
        let paramChangeurlStr = "https://official-joke-api.appspot.com/jokes/" + paramUrl + "/random"
        
        AF.request(urlStr).responseDecodable(of : [DataModel].self){ response in
            switch response.result{
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
         }
        }
    }
}
