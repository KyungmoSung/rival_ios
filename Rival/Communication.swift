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
    static var matchingRooms = Array<MatchingRoom>()
    static var teams = Array<Team>()
    var jsondata = [[String:AnyObject]]()
    
    static var selectedCity:String = "서울"
    static var selectedGame:String = "축구"
    static var nav_bg="soccer_img.png"
    
    let url = "http://192.168.0.5:8080"
    
    func getSessionProfile(){
        
        KOSessionTask.meTask(completionHandler: { (profile , error) -> Void in
            if profile != nil{
                let kakao : KOUser = profile as! KOUser
                if let value = kakao.id as! Int?{
                    LoginViewController.myProfile.id = value
                }
                if let value = kakao.properties["nickname"] as? String{
                    LoginViewController.myProfile.nickname = value
                }
                if let value = kakao.properties["profile_image"] as? String{
                    LoginViewController.myProfile.profile_image = value
                }
                if let value = kakao.properties["thumbnail_image"] as? String{
                    LoginViewController.myProfile.thumbnail_image = value
                }
                self.getProfile(id: (LoginViewController.myProfile.id))
            }
        })
    }
    
    func getProfile(id:Int) {
        
        Alamofire.request(url+"/kakaoInfo", method: .get, parameters: ["_id":"\(id)"]).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                //                let kakao_id = json[0]["kakao_id"]
                //                let kakao_nickname = json[0]["kakao_nickname"]
                //                let kakao_profile_image = json[0]["kakao_profile_image"]
                //                let kakao_thumbnail_image = json[0]["kakao_thumbnail_image"]
                let myteam = json[0]["team"]
                LoginViewController.myProfile.team = myteam.stringValue
                LoginViewController.myTeam = self.getTeam(myteam.stringValue)
            }
        }
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
                            Communication.matchingRooms.append(MatchingRoom((dict["type"] as? String)!,(dict["city"] as? String)!,(dict["team"] as? String)!,(dict["emblem"] as? String)!,(dict["title"] as? String)!,(dict["contents"] as? String)!,(dict["stadium"] as? String)!,(dict["time_game"] as? String)!,(dict["people_num"] as? Int)!))
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
    
    func getTeam(_ teamName:String)->Team{
        let team:Team=Team()
        Alamofire.request(url+"/teamN", method: .get, parameters: ["name":teamName]).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                
                team.gameType = json[0]["type"].stringValue
                team.city = json[0]["city"].stringValue
                team.teamName = json[0]["name"].stringValue
                team.introduce = json[0]["introduce"].stringValue
                team.captain = json[0]["captain"].stringValue
                team.emblem = json[0]["emblem"].stringValue
                team.image = json[0]["image"].stringValue
            }
        }
        return team
    }
    func saveMatch(_ match : MatchingRoom){
        Alamofire.request(url+"/save", method: .get, parameters: ["type": match.game,"city":match.city,"team":match.team,"emblem":match.emblem,"title":match.title,"contents":match.contents,"people_num":match.peopleNum,"stadium":match.stadium,"time_game":match.time]).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
}
