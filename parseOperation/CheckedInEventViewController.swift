//
//  CheckedInEventViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/25/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class CheckedInEventViewController: UIViewController {

    var eventObjectId:String!

    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelTagline: UILabel!
    
    @IBOutlet weak var eventWebview: UIWebView!
    @IBAction func back(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTheEvent(self.eventObjectId)
     }
    
    func fetchTheEvent (eventObjectId:String){
        var query = parseEvent.query()
        query.getObjectInBackgroundWithId(eventObjectId) { (object: PFObject!, error: NSError!) -> Void in
            if object != nil {
                
                let event = object as parseEvent
                self.labelEventName.text = event.EventName
                self.labelTagline.text = event.tagLine
        
                self.eventWebview.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.aaomp.org/annual-meeting/2014%20Schedule%20at%20a%20Glance.pdf")!))
                //http://water.epa.gov/scitech/swguidance/standards/criteria/aqlife/upload/cemagenda-2.pdf http://www.aaomp.org/annual-meeting/2014%20Schedule%20at%20a%20Glance.pdf"
                self.eventWebview.scalesPageToFit = true
            
            } else {
                println("getting detail event error \(error) ")
            }
        }
    }

}
