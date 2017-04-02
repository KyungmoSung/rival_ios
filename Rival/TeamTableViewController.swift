//
//  TeamTableViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 18..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class TeamTableViewController: UITableViewController {
    
    var jsondata = [[String:AnyObject]]()
    let com = Communication()
    let dropDownCity = DropDown()
    let dropDownGame = DropDown()
    let button =  UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        
        com.getTeamsDB()
        com.getMatchingRoomsDB()
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "  \(Communication.selectedCity) ⌄", style: .plain, target: self, action: #selector(self.dropDownCityFunc(_:)))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("  \(Communication.selectedGame) ⌄", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(self.dropDownGameFunc(_:)), for: .touchUpInside)
        
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableTeam), name: NSNotification.Name(rawValue: "reload_Table_Team"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNavTeam), name: NSNotification.Name(rawValue: "reload_Nav_Team"), object: nil)
    }
    
    func reloadTableTeam(){
        self.tableView.reloadData()
    }
    func reloadNavTeam(){
        button.setTitle("  \(Communication.selectedGame) ⌄", for: .normal)
        self.navigationItem.titleView = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),for: .default)
        self.navigationItem.rightBarButtonItem?.title = "  \(Communication.selectedCity) ⌄"
    }
    
    
    func dropDownCityFunc(_ sender: UIBarButtonItem) {
        // The view to which the drop down will appear on
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        dropDownCity.anchorView = self.tableView
        // The list of items to display. Can be changed dynamically
        dropDownCity.dataSource = ["서울","경기","인천"]
        dropDownCity.bottomOffset = CGPoint(x: 0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownCity.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDownCity.selectionAction = { [unowned self] (index: Int, item: String) in
            self.navigationItem.rightBarButtonItem?.title=" \(item) ⌄"
            Communication.selectedCity=item
            
            self.com.getTeamsDB()
            self.com.getMatchingRoomsDB()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
        }
        dropDownCity.show()
    }
    
    func dropDownGameFunc(_ sender: UIBarButtonItem) {
        // The view to which the drop down will appear on
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        dropDownGame.anchorView = self.tableView
        // The list of items to display. Can be changed dynamically
        dropDownGame.dataSource = ["축구","야구","농구","족구","당구","볼링"]
        dropDownGame.bottomOffset = CGPoint(x: 0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownGame.shadowOffset=CGSize(width: 0.0, height: 10.0)
        // The list of items to display. Can be changed dynamically
        dropDownGame.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "축구" {
                Communication.nav_bg = "soccer_bg"
            }else if item == "농구"{
                Communication.nav_bg = "basketball_bg"
            }else if item == "야구"{
                Communication.nav_bg = "baseball_bg"
            }else if item == "족구"{
                Communication.nav_bg = "volleyball_bg"
            }else if item == "당구"{
                Communication.nav_bg = "billiards_bg"
            }else{
                Communication.nav_bg = "bowling_bg"
            }
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Communication.nav_bg),
                                                                        for: .default)
            self.button.setTitle("  \(item) ⌄", for: .normal)
            self.navigationItem.titleView = self.button
            Communication.selectedGame=item
            self.com.getTeamsDB()
            self.com.getMatchingRoomsDB()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_Nav_Match"), object: nil)
        }
        dropDownGame.show()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Communication.teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        let team = Communication.teams[indexPath.row]
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        cell.labelTeamName.text=team.teamName
        cell.teamEmblem.image=UIImage(named: team.emblem)
        
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let team = Communication.teams[(indexPath?.row)!]
        
        let detailViewController = segue.destination as! TeamDetailViewController
        detailViewController.sTeam = team
        
    }
}
