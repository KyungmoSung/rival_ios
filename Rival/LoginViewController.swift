//
//  LoginViewController.swift
//  Rival
//
//  Created by ParkMinwoo on 2017. 3. 13..
//  Copyright © 2017년 Sung Kyungmo. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var loginBt_kakao: UIButton!
    @IBOutlet weak var loginBt_facebook: UIButton!
    static var myProfile = User()
    static var myTeam = Team()
    
    let com = Communication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBt_kakao.imageView?.contentMode = .scaleAspectFit
        loginBt_facebook.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        let session: KOSession = KOSession.shared();
        if session.isOpen() {
            session.close()
        }
        session.presentingViewController = self
        session.open(completionHandler: { (error) -> Void in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else if session.isOpen() == true{
                self.com.getSessionProfile()
            }else{
                print("isNotOpen")
            }
        })
    }
}
