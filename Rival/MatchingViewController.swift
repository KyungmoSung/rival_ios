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
    static var teams = [Team](arrayLiteral:
        Team("축구","서울","FC병점","안녕병점~","성경모","byungjum_emblem","team_img"),
                       Team("축구","서울","FC당진","안녕당진~","박민우","dangjin_emblem","team_img"),
                       Team("축구","서울","FC철산","안녕철산~","김희중","chulsan_emblem","team_img")
    )
    var matchingRooms = [MatchingRoom]()
    var filterRooms = [MatchingRoom]()
    
    var selectedCity:String = "서울"
    static var selectedGame:String = ""
    static var img_name="soccer_img.png"
    let dropDownCity = DropDown()
    let dropDownGame = DropDown()
    let button =  UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        
        matchingRooms+=[
            MatchingRoom("축구","서울",MatchingViewController.teams[0],"축구할사람2","asdf","올림픽올림픽경기장","2017.3.13 17:00",10),
            MatchingRoom("축구","서울",MatchingViewController.teams[1],"축구할사람3","asdf","올림픽경기장","2017.3.13 17:00",9),
            MatchingRoom("축구","인천",MatchingViewController.teams[2],"축구할사람1","asdf","올림픽경기장","2017.3.13 17:00",10),
            MatchingRoom("축구","인천",MatchingViewController.teams[0],"축구할사람2","asdf","올림픽경기장","2017.3.13 17:00",9),
            MatchingRoom("축구","경기",MatchingViewController.teams[1],"축구할사람1","asdf","올림픽경기장","2017.3.13 17:00",8),
            MatchingRoom("농구","서울",MatchingViewController.teams[2],"농구할사람서울","asdf","올림픽경기장","2017.3.13 17:00",3),
            MatchingRoom("야구","서울",MatchingViewController.teams[0],"야구할사람서울","asdf","올림픽경기장","2017.3.13 17:00",6)]
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "  \(selectedCity) ⌄", style: .plain, target: self, action: #selector(dropDownCityFunc(_:)))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("  \(MatchingViewController.selectedGame) ⌄", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(dropDownGameFunc(_:)), for: .touchUpInside)
        
        self.navigationItem.titleView = button
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: MatchingViewController.img_name),for: .default)
        
        let newBackButton = UIBarButtonItem(title: "〈 Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func back(sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.setBackgroundImage(nil,for: .default)
        _ = navigationController?.popViewController(animated: true)
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
            
            
            
            // All three of these calls are equivalent
            Alamofire.request("http://192.168.120.4:8080/game", method: .get, parameters: ["city":"\(item)"], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value!)
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error as Any)
                    break
                    
                }
            }
            
            
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
        dropDownGame.dataSource = ["축구","야구","농구","족구","당구","볼링"]
        dropDownGame.bottomOffset = CGPoint(x: 0, y:self.navigationController!.navigationBar.frame.size.height+UIApplication.shared.statusBarFrame.height)
        dropDownGame.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDownGame.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "축구" {
                MatchingViewController.img_name = "soccer_bg"
            }else if item == "농구"{
                MatchingViewController.img_name = "basketball_bg"
            }else if item == "야구"{
                MatchingViewController.img_name = "baseball_bg"
            }else if item == "족구"{
                MatchingViewController.img_name = "volleyball_bg"
            }else if item == "당구"{
                MatchingViewController.img_name = "billiards_bg"
            }else{
                MatchingViewController.img_name = "bowling_bg"
            }
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: MatchingViewController.img_name),
                                                                        for: .default)
            self.button.setTitle("  \(item) ⌄", for: .normal)
            self.navigationItem.titleView = self.button
            MatchingViewController.selectedGame=item
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
        self.filterRooms = matchingRooms.filter { $0.city == selectedCity && $0.game==MatchingViewController.selectedGame}
        
        return filterRooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MatchTableViewCell
        let title = self.filterRooms[indexPath.row].title
        let stadium = self.filterRooms[indexPath.row].stadium
        let matchTime = self.filterRooms[indexPath.row].time
        let peopleNum = self.filterRooms[indexPath.row].peopleNum
        let team = self.filterRooms[indexPath.row].team
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        cell.labelTitle.text=title
        cell.labelStadium.text=stadium
        cell.labelTime.text=matchTime
        cell.labelPeopleNum.text="\(peopleNum)명"
        cell.labelTeamName.text=team.teamName
        cell.teamIMG.image=UIImage(named: team.emblem)
        
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let title = self.filterRooms[(indexPath?.row)!].title
        let stadium = self.filterRooms[(indexPath?.row)!].stadium
        let matchTime = self.filterRooms[(indexPath?.row)!].time
        let peopleNum = self.filterRooms[(indexPath?.row)!].peopleNum
        let team = self.filterRooms[(indexPath?.row)!].team
        
        
        let detailViewController = segue.destination as! MatchDetailViewController
        detailViewController.sTitle = title
        detailViewController.sStadium = stadium
        detailViewController.sTime = matchTime
        detailViewController.sNum = peopleNum
        detailViewController.sTeam = team
    }
}


