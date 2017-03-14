//
//  FirstViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 7..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import DropDown

class FirstViewController: UITableViewController {
    
    var matchingRooms = [MatchingRoom](arrayLiteral:
        MatchingRoom("soccer","서울","축구할사람1","경기장","2017.3.13 17:00",11),
                                       MatchingRoom("축구","서울","축구할사람2","경기장","2017.3.13 17:00",10),
                                       MatchingRoom("축구","서울","축구할사람3","경기장","2017.3.13 17:00",9),
                                       MatchingRoom("축구","서울","축구할사람4","경기장","2017.3.13 17:00",8),
                                       MatchingRoom("축구","서울","축구할사람5","경기장","2017.3.13 17:00",7),
                                       MatchingRoom("축구","서울","축구할사람6","경기장","2017.3.13 17:00",6),
                                       MatchingRoom("축구","인천","축구할사람1","경기장","2017.3.13 17:00",10),
                                       MatchingRoom("축구","인천","축구할사람2","경기장","2017.3.13 17:00",9),
                                       MatchingRoom("축구","경기","축구할사람1","경기장","2017.3.13 17:00",8),
                                       MatchingRoom("농구","서울","농구할사람서울","경기장","2017.3.13 17:00",3),
                                       MatchingRoom("농구","인천","농구할사람인천","경기장","2017.3.13 17:00",4),
                                       MatchingRoom("농구","경기","농구할사람경기","경기장","2017.3.13 17:00",5),
                                       MatchingRoom("야구","서울","야구할사람서울","경기장","2017.3.13 17:00",6),
                                       MatchingRoom("야구","인천","야구할사람인천","경기장","2017.3.13 17:00",7),
                                       MatchingRoom("야구","경기","야구할사람경기","경기장","2017.3.13 17:00",8))
    
    var filterRooms = [MatchingRoom]()
    
    var selectedCity:String = "서울"
    var selectedGame:String = "축구"
    
    let dropDownCity = DropDown()
    let dropDownGame = DropDown()
    let button =  UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(selectedCity) ⌄", style: .plain, target: self, action: #selector(dropDownCityFunc(_:)))
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("\(selectedGame) ⌄", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(dropDownGameFunc(_:)), for: .touchUpInside)
        self.navigationItem.titleView = button
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
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
            self.selectedCity=item
            self.tableView.reloadData()
            print("Selected item: \(item) at index: \(index)")
        }
        dropDownCity.show()
    }
    
    func dropDownGameFunc(_ sender: UIBarButtonItem) {
        // The view to which the drop down will appear on
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 60
        dropDownGame.anchorView = self.tableView
        // The list of items to display. Can be changed dynamically
        dropDownGame.dataSource = ["축구","농구","야구"]
        dropDownGame.bottomOffset = CGPoint(x: 0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownGame.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDownGame.selectionAction = { [unowned self] (index: Int, item: String) in
            self.button.setTitle("  \(item) ⌄", for: .normal)
            self.navigationItem.titleView = self.button
            self.selectedGame=item
            self.tableView.reloadData()
            print("Selected item: \(item) at index: \(index)")
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
        
        self.filterRooms = matchingRooms.filter { $0.city == selectedCity && $0.game==selectedGame}
        
        return filterRooms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! TableViewCell
        let title = self.filterRooms[indexPath.row].title
        let stadium = self.filterRooms[indexPath.row].stadium
        let matchTime = self.filterRooms[indexPath.row].time
        let peopleNum = self.filterRooms[indexPath.row].peopleNum
        
        cell.labelTitle.text=title
        cell.labelStadium.text=stadium
        cell.labelTime.text=matchTime
        cell.labelPeopleNum.text="\(peopleNum)명"
        
        // Configure the cell...
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


