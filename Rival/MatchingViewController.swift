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
    
    // MARK: - Properties
    let dropDownCity = DropDown()
    let dropDownGame = DropDown()
    let button =  UIButton(type: .custom)
    var jsondata = [[String:AnyObject]]()
    let com = Communication()
    var filteredRooms = Array<MatchingRoom>()
    var searchController = UISearchController()
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Database from server
        com.getTeamsDB()
        com.getMatchingRoomsDB()
        
        // Setup the NavigationBar
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("    \(Communication.selectedGame) ⌄", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(dropDownGameFunc(_:)), for: .touchUpInside)
        
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.contentMode = .scaleToFill
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        
        // Setup the NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableMatch), name: NSNotification.Name(rawValue: "reload_Table_Match"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNavMatch), name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
        
        // Setup the SearchController
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            definesPresentationContext = true
            controller.searchBar.scopeButtonTitles=["제목","팀명","경기장"]
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.barTintColor = UIColor.white
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Reload Data
    func reloadTableMatch(){
        self.tableView.reloadData()
    }
    
    func reloadNavMatch(){
        button.setTitle("    \(Communication.selectedGame) ⌄", for: .normal)
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        self.navigationItem.prompt = Communication.selectedCity
        
    }
    
    
    // MARK: - DropDown menu
    func dropDownGameFunc(_ sender: UIBarButtonItem) {
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        dropDownGame.anchorView = self.tableView
        dropDownCity.anchorView = self.tableView
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
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive && searchController.searchBar.text != ""){
            return self.filteredRooms.count
        }
        return Communication.matchingRooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MatchTableViewCell
        let room: MatchingRoom
        
        if (self.searchController.isActive && self.searchController.searchBar.text != ""){
            room = self.filteredRooms[indexPath.row]
        } else {
            room = Communication.matchingRooms[indexPath.row]
        }
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        cell.labelTitle.text=room.title
        cell.labelStadium.text=room.stadium
        cell.labelTime.text=room.time
        cell.labelPeopleNum.text="\(room.peopleNum)명"
        cell.labelTeamName.text=room.team
        cell.emblem.image=UIImage(named: room.emblem)
        
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let room: MatchingRoom
                
                if (self.searchController.isActive && self.searchController.searchBar.text != ""){
                    room = self.filteredRooms[indexPath.row]
                } else {
                    room = Communication.matchingRooms[indexPath.row]
                }
                
                let detailViewController = segue.destination as! MatchDetailViewController
                
                detailViewController.sTitle = room.title
                detailViewController.sStadium = room.stadium
                detailViewController.sTime = room.time
                detailViewController.sNum = room.peopleNum
                detailViewController.sTeam = com.getTeam(room.team)
                detailViewController.sTeamName = room.team
                detailViewController.sTeamEmblem = room.emblem
            }
        }}
}

// MARK: - SearchBar updating
extension MatchingViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        filteredRooms.removeAll(keepingCapacity: false)
        let scope = searchController.searchBar.selectedScopeButtonIndex
        filteredRooms = Communication.matchingRooms.filter { room in
            switch scope{
            case 0: // Title
                return room.title.lowercased().contains((searchController.searchBar.text?.lowercased())!)
            case 1: // Team name
                return room.team.lowercased().contains((searchController.searchBar.text?.lowercased())!)
            case 2: // Stadium
                return room.stadium.lowercased().contains((searchController.searchBar.text?.lowercased())!)
            default:
                return true
            }
        }
        self.tableView.reloadData()
    }
}




