//
//  CategoryViewController.swift
//
//
//  Created by Sung Kyungmo on 2017. 3. 17..
//
//

import UIKit
import SideMenu

class CategoryViewController: UIViewController{
    
    @IBOutlet weak var btn_bowling: UIButton!
    @IBOutlet weak var btn_billiards: UIButton!
    @IBOutlet weak var btn_volleyball: UIButton!
    @IBOutlet weak var btn_basketball: UIButton!
    @IBOutlet weak var btn_baseball: UIButton!
    @IBOutlet weak var btn_soccer: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationBackgroundColor = UIColor.clear
        SideMenuManager.menuWidth = CGFloat(max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.5), 240))
        let button =  UIButton(type: .custom)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        button.setTitle("RIVAL", for: .normal)
        button.setTitleColor(UIColor(red: 43.0/255.0, green: 47.0/255.0, blue: 74.0/255.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        self.navigationItem.titleView = button
        btn_soccer.setTitleColor(.white, for:.normal)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedSoccer(_ sender: Any) {
        Communication.selectedGame = "축구"
        Communication.nav_bg = "soccer_bg"
        
    }
    @IBAction func clickedBaseball(_ sender: Any) {
        Communication.selectedGame = "야구"
        Communication.nav_bg = "baseball_bg"
    }
    
    @IBAction func clickedBasketball(_ sender: Any) {
        Communication.selectedGame = "농구"
        Communication.nav_bg = "basketball_bg"
    }
    
    @IBAction func clickedVolleyball(_ sender: Any) {
        Communication.selectedGame = "족구"
        Communication.nav_bg = "volleyball_bg"
    }
    
    @IBAction func clickedBilliards(_ sender: Any) {
        Communication.selectedGame = "당구"
        Communication.nav_bg = "billiards_bg"
    }
    
    @IBAction func clickedBowling(_ sender: Any) {
        Communication.selectedGame = "볼링"
        Communication.nav_bg = "bowling_bg"
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
