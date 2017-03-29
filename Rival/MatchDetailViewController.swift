//
//  DetailViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 16..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class MatchDetailViewController: UITableViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPeopleNum: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelStadium: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    @IBOutlet weak var teamEmblem: UIImageView!
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
        
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! TeamDetailViewController
        detailViewController.sTeam = sTeam
    }
    
    
}
