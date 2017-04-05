//
//  StadiumDetailView.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 4. 3..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class StadiumDetailViewController: UITableViewController,MTMapViewDelegate {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var stadium_name: UILabel!
    @IBOutlet weak var location_name: UILabel!
    @IBOutlet weak var road_address: UILabel!
    @IBOutlet weak var holiday: UILabel!
    @IBOutlet weak var weekday_time: UILabel!
    @IBOutlet weak var holiday_time: UILabel!
    @IBOutlet weak var b_fee: UILabel!
    @IBOutlet weak var fare: UILabel!
    @IBOutlet weak var excess_fare: UILabel!
    @IBOutlet weak var book_way: UILabel!
    @IBOutlet weak var management_agency: UILabel!
    @IBOutlet weak var phone_num: UILabel!
    @IBOutlet weak var homepage: UILabel!
    @IBOutlet weak var information: UILabel!
    
    var stadium: Stadium!
    let DaumMap = DaumMapAPI()
    var fee:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(stadium.b_fee=="N"){fee = "무료"}
        else if (stadium.b_fee=="N"){fee = "유료"}
        else{fee = "정보없음"}
        type.text = stadium.type
        stadium_name.text = stadium.stadium_name
        location_name.text = stadium.location_name
        road_address.text = stadium.road_address
        weekday_time.text = "평일 \(stadium.weekday_time_start) ~ \( stadium.weekday_time_end)"
        holiday_time.text = "주말 \(stadium.holiday_time_start) ~ \(stadium.holiday_time_end)"
        b_fee.text = fee
        management_agency.text = "\(stadium.management_agency) \(stadium.department)"
        setText(holiday , stadium.holiday)
        setText(fare,stadium.fare)
        setText(excess_fare , stadium.excess_fare)
        setText(book_way,stadium.book_way)
        setText(phone_num , stadium.phone_num)
        setText(homepage , stadium.homepage)
        setText(information , stadium.information)
        
        let map = DaumMap.setDaumMap(mapView: mapView,name:stadium.stadium_name, latitude: stadium.latitude, longitude: stadium.longitude)
        map.delegate = self
        mapView.addSubview(map)
    }
    func setText(_ label:UILabel,_ text:String){
        if(text==""){
            label.text = "정보없음"
        }
        else{
            label.text = text
        }
    }
    
}
