//
//  User.swift
//  Rival
//
//  Created by ParkMinwoo on 2017. 3. 19..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation

class User {
    
    var id: Int
    var nickname: String
    var profile_image: String
    var thumbnail_image: String
    var team: String
    
    init(_ id: Int, _ nickname: String,_ profile_image: String,_ thumbnail_image: String,_ team: String) {
        self.id = id
        self.nickname = nickname
        self.profile_image = profile_image
        self.thumbnail_image = thumbnail_image
        self.team = team
    }
    
    init() {
        self.id = 0
        self.nickname = ""
        self.profile_image = ""
        self.thumbnail_image = ""
        self.team = ""
    }
    
}
