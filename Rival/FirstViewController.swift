//
//  FirstViewController.swift
//  Rival
//
//  Created by Sung Kyungmo on 2017. 3. 7..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import UIKit
import DropDown

class FirstViewController: UIViewController {
    let dropDown = DropDown()
    
    @IBOutlet weak var selectLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func dropDownFunc(_ sender: Any) {
        // The view to which the drop down will appear on
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.anchorView = self.selectLocation
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["서울","경기","인천"]
        dropDown.bottomOffset = CGPoint(x: 0, y:self.selectLocation.frame.size.height)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectLocation.setTitle("\(item)", for: .normal)
            print("Selected item: \(item) at index: \(index)")
        }
        dropDown.show()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


