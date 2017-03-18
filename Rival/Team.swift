//
//  Team.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 18..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation

class Team {
    var gameType:String
    var teamName:String
    var emblem:String
    var image:String
    var city:String
    var introduce:String
    var captain: String
    
    init(_ gameType:String,_ city: String,_ teamName: String,_ introduce: String,_ captain: String, _ emblem: String,_ image: String){
        self.gameType = gameType
        self.teamName = teamName
        self.emblem = emblem
        self.image = image
        self.city = city
        self.introduce = introduce
        self.captain = captain
    }
}

