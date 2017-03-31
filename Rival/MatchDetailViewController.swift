//
//  DetailViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 16..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class MatchDetailViewController: UITableViewController,MTMapViewDelegate {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPeopleNum: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelStadium: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    @IBOutlet weak var teamEmblem: UIImageView!
    @IBOutlet var mapView: UIView!
    
    var sTitle: String? = nil
    var sNum: Int? = nil
    var sTime: String? = nil
    var sStadium: String? = nil
    var sTeamName: String? = nil
    var sTeamEmblem: String? = nil
    var sTeam: Team!
    override func viewDidLoad() {
        labelTitle.text = sTitle!
        labelPeopleNum.text = "인원 : \(sNum!)명"
        labelTime.text = "시간 : \(sTime!)"
        labelStadium.text = "장소 : \(sStadium!)"
        labelTeamName.text = sTeamName!
        teamEmblem.image=UIImage(named: sTeamEmblem!)
        let map: MTMapView = MTMapView(frame: CGRect(x: 0, y: 0, width: mapView.frame.size.width, height: mapView.frame.size.height))
        map.daumMapApiKey = "ba31dfe7a94d5305d5821ea5b004a5c9"
        map.delegate = self
        map.baseMapType = .standard
        mapView.addSubview(map)
        
        super.viewDidLoad()
        
    }
    
    @IBAction func openDaumMap(_ sender: Any) {
        let daumMap = "daummaps://open"
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! TeamDetailViewController
        detailViewController.sTeam = sTeam
    }
    
    
}
