//
//  Stadium.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 4. 3..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation

class Stadium {
    
    var id:String
    var stadium_name:String
    var location_name:String
    var type:String
    var holiday:String
    var weekday_time_start:String
    var weekday_time_end:String
    var holiday_time_start:String
    var holiday_time_end:String
    var b_fee:String
    var standard_time:String
    var fare:String
    var excess_fare:String
    var information:String
    var book_way:String
    var road_address:String
    var management_agency:String
    var department:String
    var phone_num:String
    var homepage:String
    var latitude:Double
    var longitude:Double
    
    init(_ id:String,
         _ stadium_name:String,
         _ location_name:String,
         _ type:String,
         _ holiday:String,
         _ weekday_time_start:String,
         _ weekday_time_end:String,
         _ holiday_time_start:String,
         _ holiday_time_end:String,
         _ b_fee:String,
        _ standard_time:String,
         _ fare:String,
         _ excess_fare:String,
         _ information:String,
         _ book_way:String,
         _ road_address:String,
         _ management_agency:String,
         _ department:String,
         _ phone_num:String,
         _ homepage:String,
         _ latitude:Double,
         _ longitude:Double) {
        self.id = id
        self.stadium_name = stadium_name
        self.location_name = location_name
        self.type = type
        self.holiday = holiday
        self.weekday_time_start = weekday_time_start
        self.weekday_time_end = weekday_time_end
        self.holiday_time_start = holiday_time_start
        self.holiday_time_end = holiday_time_end
        self.b_fee = b_fee
        self.standard_time = standard_time
        self.fare = fare
        self.excess_fare = excess_fare
        self.information = information
        self.book_way = book_way
        self.road_address = road_address
        self.management_agency = management_agency
        self.department = department
        self.phone_num = phone_num
        self.homepage = homepage
        self.latitude = latitude
        self.longitude = longitude
    }
}

