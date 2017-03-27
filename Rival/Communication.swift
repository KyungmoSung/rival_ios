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
    
    func getProfile(id:Int) {
        
        Alamofire.request(url+"/kakaoInfo", method: .get, parameters: ["_id":"\(id)"]).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                //                let kakao_id = json[0]["kakao_id"]
                //                let kakao_nickname = json[0]["kakao_nickname"]
                //                let kakao_profile_image = json[0]["kakao_profile_image"]
                //                let kakao_thumbnail_image = json[0]["kakao_thumbnail_image"]
                let myteam = json[0]["team"]
                //print("\(json)  /  team =  \(myteam.stringValue)")
                LoginViewController.myProfile.team = myteam.stringValue
                self.getMyTeam(teamName:myteam.stringValue)
                
            }
        }
    }
    
    
    func getMatchingRoomsDB(){
        Communication.matchingRooms.removeAll()
        Alamofire.request(url+"/game", method: .get, parameters: ["city":Communication.selectedCity,"type":Communication.selectedGame]).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                print(responseData.result.value!)
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
        }
    }
    
    func getMyTeam(teamName:String){
        Alamofire.request(url+"/teamN", method: .get, parameters: ["name":teamName]).responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                LoginViewController.myTeam=Team((json[0]["type"].stringValue),(json[0]["city"].stringValue),(json[0]["name"].stringValue),(json[0]["introduce"].stringValue),(json[0]["captain"].stringValue),(json[0]["emblem"].stringValue),(json[0]["image"].stringValue))
            }
        }
        
    }
    
}
