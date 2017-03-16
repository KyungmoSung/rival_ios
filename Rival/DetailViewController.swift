//
//  DetailViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 16..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
   
    @IBOutlet weak var TeamIMG: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPeopleNum: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelStadium: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    var sTitle: String = ""
    var sNum: Int = 0
    var sTime: String = ""
    var sStadium: String = ""
    var sTeamName: String = ""
    var sTeamIMG: String = ""
    
    override func viewDidLoad() {
        labelTitle.text = sTitle
        labelPeopleNum.text = "인원 : \(sNum)명"
        labelTime.text = "경기 시간 : \(sTime)"
        labelStadium.text = "경기장 : \(sStadium)"
        labelTeamName.text = sTeamName
        
        super.viewDidLoad()
    }
}
