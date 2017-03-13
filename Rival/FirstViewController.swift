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
    
    var soccer:[String:[String:Int]]=["서울":["2:2ㄱㄱ":2,"3:3ㄱ":3],"인천":["4:4":4]]
    var selectedCity:String = "서울"
    
    
    let dropDown = DropDown()
    
    @IBOutlet var dataTableView: UITableView!
    @IBOutlet weak var selectLocation: UIBarButtonItem!
    @IBOutlet weak var matchingNav: UINavigationItem!
    
    override func viewDidLoad() {
        matchingNav.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(dropDownFunc(_:)))
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func dropDownFunc(_ sender: UIBarButtonItem) {
        // The view to which the drop down will appear on
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.anchorView = self.selectLocation
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["서울","경기","인천"]
        dropDown.bottomOffset = CGPoint(x: 0, y:0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.matchingNav.title=item
            self.selectedCity=item
            self.tableView.reloadData()
            print("Selected item: \(item) at index: \(index)")
        }
        dropDown.show()
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
        let gameCategory = Array(soccer[selectedCity]!)
        return gameCategory.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
     
        let gameCategory = soccer[selectedCity]!
        let titles = Array(gameCategory.keys)
        let peopleNums = Array(gameCategory.values)
        let title = titles[indexPath.row]
        let peopleNum = peopleNums[indexPath.row]
        cell.textLabel?.text=title
        cell.detailTextLabel?.text="\(peopleNum)"
        
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


