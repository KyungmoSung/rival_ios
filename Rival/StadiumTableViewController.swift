//
//  StadiumTableViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 4. 3..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit

class StadiumTableViewController: UITableViewController {
    let com = Communication()
    let indicator = ActivityIndicator()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = indicator.setActivityIndicator(view: self.view)
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        com.getStadium(type:"축구장")
        
        // Setup the NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableStadium), name: NSNotification.Name(rawValue: "reload_Table_Stadium"), object: nil)
    }
    
    // MARK: - Reload Data
    func reloadTableStadium(){
        activityIndicator.stopAnimating()
        self.tableView.reloadData()
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
        return Communication.stadium.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stadiumCell", for: indexPath)  as! StadiumTableViewCell
        
        let stadium = Communication.stadium[indexPath.row]
        
        cell.label_name.text=stadium.stadium_name
        cell.label_location.text=stadium.road_address
        cell.button_detail.tag = indexPath.row
        return cell
    }
    
    @IBAction func tabButtonDetail(_ sender: UIButton) {
        let buttonRow = sender.tag
        StadiumDetailViewController.stadium = Communication.stadium[buttonRow]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "select"){
            var indexPath = self.tableView.indexPathForSelectedRow
            let stadium = Communication.stadium[(indexPath?.row)!]
            let detailViewController = segue.destination as! AddMatchingViewController
            detailViewController.selectedStadium = stadium.stadium_name
        }
    }
}
