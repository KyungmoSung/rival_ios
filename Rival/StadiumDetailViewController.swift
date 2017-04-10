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
    
    static var stadium: Stadium!
    let DaumMap = DaumMapAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set text to Label
        type.text = StadiumDetailViewController.stadium.type
        stadium_name.text = StadiumDetailViewController.stadium.stadium_name
        location_name.text = StadiumDetailViewController.stadium.location_name
        road_address.text = StadiumDetailViewController.stadium.road_address
        weekday_time.text = setText("평일 : ","\(StadiumDetailViewController.stadium.weekday_time_start) ~ \( StadiumDetailViewController.stadium.weekday_time_end)")
        holiday_time.text = setText("주말 : ","\(StadiumDetailViewController.stadium.holiday_time_start) ~ \(StadiumDetailViewController.stadium.holiday_time_end)")
        b_fee.text = checkFee(StadiumDetailViewController.stadium.b_fee)
        management_agency.text = "\(StadiumDetailViewController.stadium.management_agency) \(StadiumDetailViewController.stadium.department)"
        holiday.text = setText("", StadiumDetailViewController.stadium.holiday)
        fare.text = setText("사용료 : ",StadiumDetailViewController.stadium.fare)
        excess_fare.text = setText("초과사용료 : ", StadiumDetailViewController.stadium.excess_fare)
        book_way.text = setText("",StadiumDetailViewController.stadium.book_way)
        phone_num.text = setText("", StadiumDetailViewController.stadium.phone_num)
        homepage.text = setText("", StadiumDetailViewController.stadium.homepage)
        information.text = setText("", StadiumDetailViewController.stadium.information)
        
        //Set DaumMap
        let map = DaumMap.setDaumMap(mapView: mapView,name:StadiumDetailViewController.stadium.stadium_name, latitude: StadiumDetailViewController.stadium.latitude, longitude: StadiumDetailViewController.stadium.longitude)
        map.delegate = self
        mapView.addSubview(map)
    }
    
    //Check Fee YES or NO
    func checkFee(_ text:String) -> String{
        if(text=="N"){return "무료"}
        else if (text=="Y"){return "유료"}
        else{return "정보없음"}
    }
    
    //Check null data
    func setText(_ titleText:String,_ text:String) -> String{
        if(text==StadiumDetailViewController.stadium.fare||text==StadiumDetailViewController.stadium.excess_fare){
            if(text==""){
                return (titleText + "정보없음")
            }
            else{
                return (titleText + text + " 원")
            }
        }
        else if(text==""){
            return "정보없음"
        }
        else{
            return (titleText + text)
        }
    }
    
}
