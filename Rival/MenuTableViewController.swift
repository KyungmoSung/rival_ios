//
//  MenuTableViewController.swift
//  Rival
//
//  Created by ParkMinwoo on 2017. 3. 18..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import Alamofire

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var kakaoThumbnail: UIImageView!
    @IBOutlet weak var kakaoNick: UILabel!
    @IBOutlet weak var labelTeamName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kakaoThumbnail.layer.cornerRadius = kakaoThumbnail.frame.size.width/2
        kakaoThumbnail.clipsToBounds = true
        if (LoginViewController.myProfile.thumbnail_image != ""){
            kakaoNick.text = LoginViewController.myProfile.nickname
            kakaoThumbnail.image = UIImage(data: NSData(contentsOf: NSURL(string: (LoginViewController.myProfile.thumbnail_image))! as URL)! as Data)
            labelTeamName.text=LoginViewController.myTeam.teamName
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Logout cell clicked
        if indexPath.row == 6 {
            KOSession.shared().logoutAndClose { [weak self] (success, error) -> Void in
                _ = self?.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let team = LoginViewController.myTeam
        
        let detailViewController = segue.destination as! TeamDetailViewController
        detailViewController.sTeam = team
        
    }
}
