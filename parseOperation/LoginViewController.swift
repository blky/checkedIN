//
//  LoginViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/23/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textUsername: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBAction func onSignin(sender: AnyObject) {
        loginToParse()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "sign in "

     }

    func loginToParse(){
        PFUser.logInWithUsernameInBackground(textUsername.text, password:textPassword.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if error == nil {
                println("user login")
                println("current user is \(PFUser.currentUser().username)")
                
            } else {
                println("login error")
            }
        }
    }
    }
