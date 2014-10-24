//
//  myEventsViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/24/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class myEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var events:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My events"
        tableView.delegate = self
        tableView.dataSource = self
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        relation.query().findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error != nil {
                println("error retrieving rsvped events")
            } else {
                self.events = objects
                
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of cell: \(events?.count ?? 0)")
        return events?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as UITableViewCell
        
        var event = events?[indexPath.row] as parseEvent
        cell.textLabel.text = event.EventName
        
        
        
        return cell
    }

}
