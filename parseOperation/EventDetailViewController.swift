import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelTagline: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelMaxRsvped: UILabel!
    @IBOutlet weak var buttonunRSVP: UIButton!
    @IBOutlet weak var buttonCheckedIn: UIButton!
    @IBOutlet weak var buttonRSVP: UIButton!
    
    
    
    var eventNameAndRsvped:NSDictionary?
    var eventName:String!
    var isRsvped:Bool!
    
    @IBAction func onRsvp(sender: AnyObject) {
        
        //println("onrsvp")
    }
    
    
    
    @IBAction func removeRSVP(sender: AnyObject) {
        
        //println("unrsvp")

        
    }
    
    
    @IBAction func checkIN(sender: UIButton) {
        UIAlertView(title: "checkein", message: "location or iBeacon implementation needed here", delegate: self, cancelButtonTitle: "OK")
    }
    
     @IBAction func back(sender: AnyObject) {
   
    self.dismissViewControllerAnimated(true , completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCheckedIn.alpha = 0
        buttonunRSVP.alpha = 0
        buttonRSVP.alpha = 0
        
        if eventNameAndRsvped != nil {
            
            self.eventName = eventNameAndRsvped?.objectForKey("eventName")  as String?
            self.isRsvped = eventNameAndRsvped?.objectForKey("isRsvped")  as   Bool?
            
            if isRsvped! {
                 buttonunRSVP.alpha = 1
                buttonCheckedIn.alpha = 1
            } else {
                buttonRSVP.alpha = 1
            }
        }
        
        if  eventName != nil   {
            fetchTheEvents(eventName)

        }
        

    }
 
    func fetchTheEvents(eventName:String){
        var query = parseEvent.query()
        query.whereKey("EventName", equalTo:  eventName)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject!, error:NSError!) -> Void in
            println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
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
