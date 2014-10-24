//
//  signUpViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/24/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {
 
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textScreenName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textZipcode: UITextField!
    
    @IBOutlet weak var textusername: UITextField!
    
    @IBAction func onSignUp(sender: AnyObject) {
 
        var newUser = PFUser()
        newUser.username = textusername.text
        newUser.password = textPassword.text
        newUser.email = textEmail.text
        newUser["zipcode"] = textZipcode.text
        newUser["screenName"] = textScreenName.text
        newUser.signUpInBackgroundWithBlock { (successed: Bool, error: NSError!) -> Void in
            
            if error != nil {
                println("user sign up error:\(error)")
                UIAlertView(title: "sign up error", message: "\(error)", delegate: nil, cancelButtonTitle: "OK").show()
            } else {
                println("user sign up successfully")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SIGN UP"

     }
 
    

}
