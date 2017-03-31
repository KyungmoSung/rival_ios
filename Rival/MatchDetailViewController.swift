//
//  DetailViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 16..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import EventKit

class MatchDetailViewController: UITableViewController,MTMapViewDelegate {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPeopleNum: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelStadium: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    @IBOutlet weak var teamEmblem: UIImageView!
    @IBOutlet var mapView: UIView!
    
    var sTitle: String!
    var sNum: Int!
    var sTime: String!
    var sStadium: String!
    var sTeamName: String!
    var sTeamEmblem: String!
    var sTeam: Team!
    var latitude: Double = 37.4981688
    var longitude: Double = 127.0484572
    
    override func viewDidLoad() {
        labelTitle.text = sTitle!
        labelPeopleNum.text = "인원 : \(sNum!)명"
        labelTime.text = "\(sTime!)"
        labelStadium.text = "\(sStadium!)"
        labelTeamName.text = sTeamName!
        teamEmblem.image=UIImage(named: sTeamEmblem!)
        
        let map: MTMapView = MTMapView(frame: CGRect(x: 0, y: 0, width: mapView.frame.size.width, height: mapView.frame.size.height))
        map.addPOIItems([poiItem(name: self.sStadium!, latitude: self.latitude, longitude: self.longitude)])
        map.fitAreaToShowAllPOIItems()  // 모든 마커가 보이게 카메라 위치/줌 조정
        map.daumMapApiKey = "ba31dfe7a94d5305d5821ea5b004a5c9"
        map.delegate = self
        map.baseMapType = .standard
        mapView.addSubview(map)
        
        super.viewDidLoad()
    }
    
    @IBAction func openDaumMap(_ sender: Any) {
        let daumMap = "daummaps://look?p=\(self.latitude),\(self.longitude)"
        let daumMapAppstore = "https://itunes.apple.com/us/app/id304608425?mt=8"
        let daumMapURL = NSURL(string: daumMap)
        let daumMapAppstoreURL = NSURL(string: daumMapAppstore)
        
        if UIApplication.shared.canOpenURL(daumMapURL! as URL) {
            UIApplication.shared.open(daumMapURL! as URL)
        }
        else {
            UIApplication.shared.open(daumMapAppstoreURL! as URL)
        }
        
    }
    
    @IBAction func openCalendar(_ sender: Any) {
        
        let nscal = NSCalendar.autoupdatingCurrent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        let startDate = dateFormatter.date(from: self.sTime)!
        let endDate = nscal.date(byAdding: .hour, value: 1, to: startDate)
        let interval = startDate.timeIntervalSinceReferenceDate
        
        let calendar = "calshow:\(interval)"
        let calendarURL = NSURL(string: calendar)
        
        let alert_add = UIAlertController(title: "경기일정등록", message: "\n일정을 캘린더에 등록하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert_add.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
        alert_add.addAction(UIAlertAction(title: "등록", style: UIAlertActionStyle.destructive, handler: { action in
            self.addEventToCalendar(title: self.sTitle, description: "", startDate: startDate as NSDate, endDate: endDate! as NSDate)
            let alert_move = UIAlertController(title: "캘린더", message: "\n일정을 등록했습니다\n캘린더로 이동하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            alert_move.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
            alert_move.addAction(UIAlertAction(title: "열기", style: UIAlertActionStyle.destructive, handler: { action in
                if UIApplication.shared.canOpenURL(calendarURL! as URL) {
                    UIApplication.shared.open(calendarURL! as URL)
                }
                else{
                    print("fail")
                }
            }))
            self.present(alert_move, animated: true, completion: nil)
        }))
        self.present(alert_add, animated: true, completion: nil)
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: NSDate, endDate: NSDate, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate as Date
                event.endDate = endDate as Date
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    func poiItem(name: String, latitude: Double, longitude: Double) -> MTMapPOIItem {
        let item = MTMapPOIItem()
        item.itemName = name
        item.markerType = .redPin
        item.markerSelectedType = .redPin
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .dropFromHeaven
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)    // 마커 위치 조정
        
        return item
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! TeamDetailViewController
        detailViewController.sTeam = sTeam
    }
    
    
}
