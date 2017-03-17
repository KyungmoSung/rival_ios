//
//  CategoryViewController.swift
//
//
//  Created by Sung Kyungmo on 2017. 3. 17..
//
//

import UIKit


class CategoryViewController: UIViewController{
    
    @IBOutlet weak var btn_bowling: UIButton!
    @IBOutlet weak var btn_billiards: UIButton!
    @IBOutlet weak var btn_volleyball: UIButton!
    @IBOutlet weak var btn_basketball: UIButton!
    @IBOutlet weak var btn_baseball: UIButton!
    @IBOutlet weak var btn_soccer: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button =  UIButton(type: .custom)
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("RIVAL", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        
        self.navigationItem.titleView = button

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"nav_bg"),for: .default)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedSoccer(_ sender: Any) {
        MatchingViewController.selectedGame = "축구"
        MatchingViewController.img_name = "soccer_bg"
    }
    @IBAction func clickedBaseball(_ sender: Any) {
        MatchingViewController.selectedGame = "야구"
        MatchingViewController.img_name = "baseball_bg"
    }
    
    @IBAction func clickedBasketball(_ sender: Any) {
        MatchingViewController.selectedGame = "농구"
        MatchingViewController.img_name = "basketball_bg"
    }
    
    @IBAction func clickedVolleyball(_ sender: Any) {
        MatchingViewController.selectedGame = "족구"
        MatchingViewController.img_name = "volleyball_bg"
    }
    
    @IBAction func clickedBilliards(_ sender: Any) {
        MatchingViewController.selectedGame = "당구"
        MatchingViewController.img_name = "billiards_bg"
    }
    
    @IBAction func clickedBowling(_ sender: Any) {
        MatchingViewController.selectedGame = "볼링"
        MatchingViewController.img_name = "bowling_bg"
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
