//
//  EventUpdateViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/23/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class EventUpdateViewController: UIViewController {

    @IBOutlet weak var textEventName: UITextField!
    @IBOutlet weak var textTagline: UITextField!
    @IBOutlet weak var textCity: UITextField!
    @IBOutlet weak var textMaxrsvp: UITextField!
    
    
    @IBAction func addEvents(sender: AnyObject) {
        
        var newEvent = parseEvent()
        
        newEvent.EventName = textEventName.text
        newEvent.tagLine = textTagline.text
        newEvent.cityName = textCity.text
        newEvent.rsvpMax = (textMaxrsvp.text as NSString).integerValue
        newEvent.saveInBackgroundWithBlock { ( _ : Bool, error: NSError!) -> Void in
            
            if error != nil {
                println("add event erorr \(error)")
            } else {
                println( "event added ")
            }
        }
        
        
        
//        newUser.username = textusername.text
//        newUser.password = textPassword.text
//        newUser.email = textEmail.text
//        newUser["zipcode"] = textZipcode.text
//        newUser["screenName"] = textScreenName.text
//        newUser.signUpInBackgroundWithBlock { (successed: Bool, error: NSError!) -> Void in
//            
//            if error != nil {
//                println("user sign up error:\(error)")
//                UIAlertView(title: "sign up error", message: "\(error)", delegate: nil, cancelButtonTitle: "OK").show()
//            } else {
//                println("user sign up successfully")
//            }
//        }
//        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Event"
       
    }

  
 

}
