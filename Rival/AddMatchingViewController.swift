//
//  AddMatchingViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 27..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import DropDown

class AddMatchingViewController: UITableViewController {
    
    let com = Communication()
    
    @IBOutlet weak var editPeopleNum: UIStepper!
    @IBOutlet weak var peopleNum: UILabel!
    @IBOutlet weak var teamEmblem: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var contentsTxt: UITextView!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var selectGameBT: UIButton!
    @IBOutlet weak var selectCityBT: UIButton!
    @IBOutlet weak var selectGameTxt: UILabel!
    @IBOutlet weak var selectCityTxt: UILabel!
    @IBOutlet weak var gameCell: UITableViewCell!
    @IBOutlet weak var cityCell: UITableViewCell!
    @IBOutlet weak var stadium: UILabel!
    
    let dropDown = DropDown()
    var dropDownData = [""]
    var numberOfPeople = 1
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = LoginViewController.myTeam.teamName
        teamEmblem.image=UIImage(named: (LoginViewController.myTeam.emblem))
        CreateDatePicker()
    }
    
    func dropDownFunc(_ label:UILabel,_ cell:UITableViewCell) {
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.dataSource = dropDownData
        dropDown.anchorView = cell
        dropDown.bottomOffset = CGPoint(x:0, y:cell.frame.size.height)
        dropDown.shadowOffset=CGSize(width: 0.0, height: 10.0)
        dropDown.selectionAction = { [] (index: Int, item: String) in
            label.text = item
        }
        dropDown.show()
    }
    
    @IBAction func selectGameBtClicked(_ sender: Any) {
        dropDownData=["축구","야구","농구","족구","당구","볼링"]
        dropDownFunc(selectGameTxt,gameCell)
        
    }
    @IBAction func selectCityBtClicked(_ sender: Any) {
        dropDownData=["서울","경기","인천"]
        dropDownFunc(selectCityTxt,cityCell)
       
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        numberOfPeople = Int(sender.value)
        peopleNum.text = "\(numberOfPeople) 명"
    }
    
    func CreateDatePicker() {
        
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 30
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateTxt.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        dateTxt.inputView = datePicker
    }// end advanceBookingAction
    
   
    func donePressed(_ sender : Any) {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        
        dateTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addMatchingButtonClicked(_ sender: Any) {
        let team = LoginViewController.myTeam.teamName
        let emblem = LoginViewController.myTeam.emblem
        let type = self.selectGameTxt.text
        let city = self.selectCityTxt.text
        let peopleNum = self.numberOfPeople
        let title = self.titleTxt.text
        let contents = self.contentsTxt.text
        let stadium = self.stadium.text
        let time = self.dateTxt.text
        com.saveMatch(MatchingRoom(type!,city!,team,emblem,title!,contents!,stadium!,time!,peopleNum))
    }
}
