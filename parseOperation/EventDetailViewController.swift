import UIKit

class EventDetailViewController: UIViewController , UIAlertViewDelegate {

    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelTagline: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelMaxRsvped: UILabel!
    @IBOutlet weak var buttonunRSVP: UIButton!
    @IBOutlet weak var buttonCheckedIn: UIButton!
    @IBOutlet weak var buttonRSVP: UIButton!

    var eventNameAndRsvped:NSDictionary?
    var eventObjectId:String!
    var isRsvped:Bool!
    
    @IBAction func onRsvp(sender: AnyObject) {
        rsvpEvent()
        UIAlertView(title: "RSVP successfully", message: "We will see you at the event!", delegate: self, cancelButtonTitle: "OK" ).show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
       // dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func removeRSVP(sender: AnyObject) {
        unRsvpEvent()
        UIAlertView(title: "Your RSVP has been removed. ", message: "We will see you the next time!", delegate: self, cancelButtonTitle: "OK" ).show()
    }
    @IBAction func checkIN(sender: UIButton) {
        checkInEvent()
        performSegueWithIdentifier("toCheckedInDetails", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toCheckedInDetails" {
            if segue.destinationViewController.isKindOfClass(CheckedInEventViewController) {
                let vc = segue.destinationViewController as CheckedInEventViewController
                vc.eventObjectId = self.eventObjectId
            } else {
                
            }
        }
        
    }
     @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true , completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCheckedIn.alpha = 0
        buttonunRSVP.alpha = 0
        buttonRSVP.alpha = 0
        if eventNameAndRsvped != nil {
            self.eventObjectId = eventNameAndRsvped?.objectForKey("objectId")  as String?
            self.isRsvped = eventNameAndRsvped?.objectForKey("isRsvped")  as   Bool?
            if isRsvped! {
                 buttonunRSVP.alpha = 1
                buttonCheckedIn.alpha = 1
            } else {
                buttonRSVP.alpha = 1
            }
        }
        if  eventObjectId != nil   {
            fetchTheEvent (eventObjectId)
        }
    }
    func checkInEvent(){
        var user = PFUser.currentUser()
        var relation = user.relationForKey("checkedIn")
        var events = parseEvent.query() as PFQuery
        events.getObjectInBackgroundWithId(eventObjectId) { (object:PFObject!, error: NSError!) -> Void in
            if object != nil {
                println("checked in successfully")
                relation.addObject(object )
                user.saveEventually()
                
            } else {
                println("checked In error \(error)")
            }
           
         }
    }
    func rsvpEvent(){
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        var events = parseEvent.query() as PFQuery
        events.getObjectInBackgroundWithId(eventObjectId ) { (object: PFObject!, error: NSError!) -> Void in
            if object != nil {
                
                relation.addObject(object)
                user.saveEventually()
            } else {
                println("rsvp event error \(error)")
            }
        }
    }
    func unRsvpEvent(){
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        var events = parseEvent.query() as PFQuery
        events.getObjectInBackgroundWithId(eventObjectId) { (object: PFObject!, error: NSError!) -> Void in
            if object != nil {
                relation.removeObject(object)
                user.saveEventually()
            } else {
                println("unrsvp event error \(error)")
    }
        }
    }
    func fetchTheEvent (eventObjectId:String){
        var query = parseEvent.query()
        query.getObjectInBackgroundWithId(eventObjectId) { (object: PFObject!, error: NSError!) -> Void in
             if object != nil {
                let event = object as parseEvent
                self.labelCity.text = event.cityName
                self.labelEventName.text = event.EventName
                self.labelTagline.text = event.tagLine
                self.labelMaxRsvped.text = "max rsvp count: \(event.rsvpMax!) "
            } else {
                println("getting detail event error \(error) ")
            }
        }
    }
}
