//
//  alamofire.swift
//  Rival
//
//  Created by ParkMinwoo on 2017. 3. 19..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation
import Alamofire

class Communication {
    
    func test() -> String {
        
        Alamofire.request("http://192.168.219.172:8080/user", method: .get, parameters: ["user_id":"test"], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    
                    //return response.result.value!
                }
                break
                
            case .failure(_):
                print(response.result.error as Any)
                break
                
            }
        }
        
        return "test"
    }
}
