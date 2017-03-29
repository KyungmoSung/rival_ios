//
//  FirstViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 7..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class MatchingViewController: UITableViewController {
    
    let dropDownCity = DropDown()
    let dropDownGame = DropDown()
    let button =  UIButton(type: .custom)
    var jsondata = [[String:AnyObject]]()
    let com = Communication()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        com.getTeamsDB()
        com.getMatchingRoomsDB()
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("    \(Communication.selectedGame) ⌄", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(dropDownGameFunc(_:)), for: .touchUpInside)
        
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        
        let newBackButton = UIBarButtonItem(title: "〈 Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableMatch), name: NSNotification.Name(rawValue: "reload_Table_Match"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNavMatch), name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
        
    }
    func reloadTableMatch(){
        self.tableView.reloadData()
    }
    func reloadNavMatch(){
        button.setTitle("    \(Communication.selectedGame) ⌄", for: .normal)
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        self.navigationItem.prompt = Communication.selectedCity
        
    }
    func back(sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.setBackgroundImage(nil,for: .default)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func dropDownGameFunc(_ sender: UIBarButtonItem) {
        
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        dropDownGame.anchorView = self.tableView
        dropDownCity.anchorView = self.tableView
        // The list of items to display. Can be changed dynamically
        dropDownCity.dataSource = ["서울","경기","인천"]
        dropDownCity.bottomOffset = CGPoint(x:0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownCity.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDownCity.selectionAction = { [unowned self] (index: Int, item: String) in
            self.navigationItem.prompt = item
            Communication.selectedCity=item
            
            self.com.getTeamsDB()
            self.com.getMatchingRoomsDB()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Team"), object: nil)
        }
        
        
        dropDownGame.dataSource = ["축구","야구","농구","족구","당구","볼링"]
        dropDownGame.bottomOffset = CGPoint(x: 0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownGame.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDownGame.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "축구" {
                Communication.nav_bg = "soccer_bg"
                self.dropDownCity.show()
            }else if item == "농구"{
                Communication.nav_bg = "basketball_bg"
                self.dropDownCity.show()
            }else if item == "야구"{
                Communication.nav_bg = "baseball_bg"
                self.dropDownCity.show()
            }else if item == "족구"{
                Communication.nav_bg = "volleyball_bg"
                self.dropDownCity.show()
            }else if item == "당구"{
                Communication.nav_bg = "billiards_bg"
                self.dropDownCity.show()
            }else{
                Communication.nav_bg = "bowling_bg"
                self.dropDownCity.show()
            }
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),
                                                                        for: .default)
            self.button.setTitle("    \(item) ⌄", for: .normal)
            self.navigationItem.titleView = self.button
            Communication.selectedGame=item
            
            self.com.getTeamsDB()
            self.com.getMatchingRoomsDB()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Team"), object: nil)
            
        }
        dropDownGame.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Communication.matchingRooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MatchTableViewCell
        let title = Communication.matchingRooms[indexPath.row].title
        let stadium = Communication.matchingRooms[indexPath.row].stadium
        let matchTime = Communication.matchingRooms[indexPath.row].time
        let peopleNum = Communication.matchingRooms[indexPath.row].peopleNum
        let team = Communication.matchingRooms[indexPath.row].team
        let emblem = Communication.matchingRooms[indexPath.row].emblem
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        cell.labelTitle.text=title
        cell.labelStadium.text=stadium
        cell.labelTime.text=matchTime
        cell.labelPeopleNum.text="\(peopleNum)명"
        cell.labelTeamName.text=team
        cell.emblem.image=UIImage(named: emblem)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            let title = Communication.matchingRooms[(indexPath.row)].title
            let stadium = Communication.matchingRooms[(indexPath.row)].stadium
            let matchTime = Communication.matchingRooms[(indexPath.row)].time
            let peopleNum = Communication.matchingRooms[(indexPath.row)].peopleNum
            let team = com.getTeam(Communication.matchingRooms[(indexPath.row)].team)
            let teamName = Communication.matchingRooms[(indexPath.row)].team
            let teamEmblem = Communication.matchingRooms[(indexPath.row)].emblem
            
            let detailViewController = segue.destination as! MatchDetailViewController
            
            detailViewController.sTitle = title
            detailViewController.sStadium = stadium
            detailViewController.sTime = matchTime
            detailViewController.sNum = peopleNum
            detailViewController.sTeam = team
            detailViewController.sTeamName = teamName
            detailViewController.sTeamEmblem = teamEmblem
            
        }
        
    }
}


