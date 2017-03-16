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
    var sTitle: String
    var sNum: Int
    var sTime: String
    var sStadium: String
    var sTeamName: String
    var sTeamIMG: String
    
    override func viewDidLoad() {
        labelTitle.text = sTitle
        labelPeopleNum.text = "\(sNum)명"
        labelTime.text = sTime
        labelStadium.text = sStadium
        labelTeamName.text = sTeamName
        TeamIMG.text = sTeamIMG
        super.viewDidLoad()
    }
}
