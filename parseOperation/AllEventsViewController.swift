import UIKit

class AllEventsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var events:NSArray?
    var allMyEvents:NSArray?
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.allMyEvents = nil
        self.events = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =   "All Events"
        tableView.delegate = self
        tableView.dataSource = self
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        refreshTableView()
    }
    override func viewWillAppear(animated: Bool) {
        refreshTableView()
    }
 
    func refresh( refreshControl : UIRefreshControl)
    {
        refreshControl.beginRefreshing()
        
        refreshTableView()
        refreshControl.endRefreshing()
    }

    func refreshTableView() {
        fetchMyEvents()
        fetchAllEvents()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEventDetailsNotYetRSVPed" {
            if segue.destinationViewController.isKindOfClass(EventDetailViewController) {
                let vc = segue.destinationViewController as EventDetailViewController
                vc.eventNameAndRsvped = sender as NSDictionary?
            }
            
        } else {
            
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of cell: \(events?.count ?? 0) ; nubmer of myevents: \(allMyEvents?.count ?? 0)")
        return events?.count ?? 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let event  = events?[indexPath.row] as parseEvent
        var eventNameAndRsvped = [ "objectId": event.objectId, "isRsvped" :isAlreadyRSVPed(event.EventName!) ]
        performSegueWithIdentifier("toEventDetailsNotYetRSVPed", sender: eventNameAndRsvped )
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("allEventsCell") as UITableViewCell
        var event = events?[indexPath.row] as parseEvent
        cell.textLabel.text = event.EventName
        cell.detailTextLabel?.text = event.tagLine
        println("table cell \(indexPath.row)")
        if isAlreadyRSVPed(event.EventName!) {
            cell.accessoryType =  UITableViewCellAccessoryType.Checkmark

        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    func fetchAllEvents(){
        println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
        var query = parseEvent.query() as PFQuery
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")

            if objects != nil {
                self.events = objects
                if self.allMyEvents != nil {
                    self.tableView.reloadData()

                }
                
            } else {
                println("fetch all events error \(error)")
            }
        
        }
    }
    
    func fetchMyEvents() {
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        relation.query().findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")

            if objects != nil {
                self.allMyEvents = objects
                if self.events != nil {
                    self.tableView.reloadData()
                }
                
            } else {
                println("fetch my all events error \(error)")
            }
        }
    }
    
    
    func isAlreadyRSVPed(eventName:String) -> Bool {
        var temp = false
         for each in self.allMyEvents! {
//            var event = each as parseEvent
//            if event.EventName  == eventName {
//                temp = true
//            }
            
            if each["EventName"]! as String == eventName {
                temp = true
            }
        }
         
        return temp
    }



}

