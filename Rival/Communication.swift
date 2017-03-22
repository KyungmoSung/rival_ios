//
//  alamofire.swift
//  Rival
//
//  Created by ParkMinwoo on 2017. 3. 19..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Communication {
    static var matchingRooms = [MatchingRoom]()
    static var teams = [Team]()
    var jsondata = [[String:AnyObject]]()
    
    static var selectedCity:String = "서울"
    static var selectedGame:String = "축구"
    static var nav_bg="soccer_img.png"
    
    let url = "http://192.168.0.5:8080"
    
    func test() -> String {
        
        Alamofire.request(url+"/user", method: .get, parameters: ["user_id":"test"], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
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
    func getMatchingRoomsDB(){
        Communication.matchingRooms.removeAll()
        Alamofire.request(url+"/game", method: .get, parameters: ["city":Communication.selectedCity,"type":Communication.selectedGame]).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar.arrayObject {
                    self.jsondata = resData as! [[String:AnyObject]]
                    if self.jsondata.count != 0{
                        for i in 0...(self.jsondata.count-1){
                            let dict = self.jsondata[i]
                            Communication.matchingRooms.append(MatchingRoom((dict["type"] as? String)!,(dict["city"] as? String)!,(dict["team"] as? String)!,(dict["title"] as? String)!,(dict["contents"] as? String)!,(dict["stadium"] as? String)!,(dict["time_game"] as? String)!,(dict["people_num"] as? Int)!))
                        }
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Table_Team"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Table_Match"), object: nil)
        }
    }
    
    func getTeamsDB(){
        Communication.teams.removeAll()
        Alamofire.request(url+"/teamCT", method: .get, parameters: ["city":Communication.selectedCity,"type":Communication.selectedGame]).responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar.arrayObject {
                    self.jsondata = resData as! [[String:AnyObject]]
                    if self.jsondata.count != 0{
                        for i in 0...(self.jsondata.count-1){
                            let dict = self.jsondata[i]
                            Communication.teams.append(Team((dict["type"] as? String)!,(dict["city"] as? String)!,(dict["name"] as? String)!,(dict["introduce"] as? String)!,(dict["captain"] as? String)!,(dict["emblem"] as? String)!,(dict["image"] as? String)!))
                        }
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Table_Match"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Table_Team"), object: nil)
        }
    }
    
}
