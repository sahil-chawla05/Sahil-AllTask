//
//  apiservice.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//

import Foundation
import Alamofire
class apiCallService{
    
    func apiCall(completionHandler : @escaping(Result<[JokeModal],Error>) -> Void){
        
        let url = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(url).responseDecodable (of : [JokeModal].self){ response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
        
    }
}
