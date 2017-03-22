//
//  TeamDetailViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 18..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class TeamDetailViewController: UITableViewController {
    
    @IBOutlet weak var teamEmblem: UIImageView!
    @IBOutlet weak var teamIMG: UIImageView!
    @IBOutlet weak var labelGameType: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    @IBOutlet weak var labelIntroduce: UILabel!
    @IBOutlet weak var labelPeopleNum: UILabel!
    @IBOutlet weak var labelCaptain: UILabel!
    @IBOutlet weak var labelTeamName_emb: UILabel!
    
    
    
    var sTeam: Team!
    
    override func viewDidLoad() {
        labelGameType.text = "종목 : \(sTeam.gameType)"
        labelCity.text = "지역 : \(sTeam.city)"
        labelTeamName.text = "팀명 : \(sTeam.teamName)"
        labelTeamName_emb.text = sTeam.teamName
        labelPeopleNum.text = "()명"
        labelIntroduce.text = sTeam.introduce
        labelCaptain.text = "주장 : \(sTeam.captain)"
        teamIMG.image=UIImage(named: (sTeam.image))
        teamEmblem.image=UIImage(named: (sTeam.emblem))
        
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("test")

    }
    
}
