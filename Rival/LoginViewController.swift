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
                KOSessionTask.meTask(completionHandler: { (profile , error) -> Void in
                    if profile != nil{
                        let kakao : KOUser = profile as! KOUser
                        if let value = kakao.id as Int?{
                            LoginViewController.myProfile.id = value
                            print("\(value) / \(LoginViewController.myProfile.id)")
                        }
                        if let value = kakao.properties["nickname"] as? String{
                            LoginViewController.myProfile.nickname = value
                            print("\(value) / \(LoginViewController.myProfile.nickname)")

                        }
                        if let value = kakao.properties["profile_image"] as? String{
                            LoginViewController.myProfile.profile_image = value
                            print("\(value) / \(LoginViewController.myProfile.profile_image)")
                        }
                        if let value = kakao.properties["thumbnail_image"] as? String{
                            LoginViewController.myProfile.thumbnail_image = value
                            print("\(value) / \(LoginViewController.myProfile.thumbnail_image)")
                        }
                        self.com.getProfile(id: (LoginViewController.myProfile.id))
                        
                        print(LoginViewController.myProfile)
                    }
                    
                })
            }else{
                print("isNotOpen")
            }
        })
    }
}
