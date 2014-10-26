import UIKit

class myEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var events:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =   "RSVPed Events"
        tableView.delegate = self
        tableView.dataSource = self
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
     }
    override func viewWillAppear(animated: Bool) {
        fetchMyEvents()
    }
    func refresh( refreshControl : UIRefreshControl)
    {   refreshControl.beginRefreshing()
        fetchMyEvents()
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of cell: \(events?.count ?? 0)")
        return events?.count ?? 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let event  = events?[indexPath.row] as parseEvent
        var eventNameAndRsvped = [ "objectId": event.objectId, "isRsvped" :true ]
        
        performSegueWithIdentifier("toEventDetail", sender: eventNameAndRsvped )
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as UITableViewCell
        var event = events?[indexPath.row] as parseEvent
        cell.textLabel.text = event.EventName
        cell.detailTextLabel?.text = event.tagLine
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEventDetail" {
            if segue.destinationViewController.isKindOfClass(EventDetailViewController) {
                let vc = segue.destinationViewController as EventDetailViewController
                 vc.eventNameAndRsvped = sender as NSDictionary?
            }
            
        } else if segue.identifier == "toAllEvents" {
            
         }
    }
    func fetchMyEvents(){
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        relation.query().findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error != nil {
                println("error retrieving rsvped events")
            } else {
                self.events = objects
                self.tableView.reloadData()
            }
        }
    }

}
