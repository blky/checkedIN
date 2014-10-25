//
//  signInViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/24/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class signInViewController: UIViewController {
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    var isSignedin = false
    
    @IBAction func onSignin(sender: AnyObject) {
        loginToParse()
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in "
        self.textPassword.text = "password"
        self.textUsername.text = "blky"
        
    }
    
    func loginToParse(){
        PFUser.logInWithUsernameInBackground(textUsername.text, password:textPassword.text) {
            
            (user: PFUser!, error: NSError!) -> Void in
            if error == nil {
                self.isSignedin = true
                 println("user login")
                println("current user is \(PFUser.currentUser().username)")
                self.performSegueWithIdentifier("toMyEvents", sender: self)
        
            } else {
                self.isSignedin = false
                 UIAlertView(title: "login error", message: "\(error)" , delegate: nil, cancelButtonTitle: "ok").show()
                
                
            }
        }
    }


}
