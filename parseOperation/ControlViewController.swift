import UIKit

class ControlViewController: UIViewController {
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        println("logout..")
        
    }
    @IBAction func rsvpEvent(sender: AnyObject) {
        // B4j82pK2mb
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        var events = parseEvent.query() as PFQuery
        events.getObjectInBackgroundWithId("B4j82pK2mb", block: { (obj:PFObject!, error:NSError!) -> Void in
            relation.addObject(obj)
            user.saveEventually()
        })
    }
    @IBAction func listrsvp(sender: AnyObject) {
        var user = PFUser.currentUser()
        var relation = user.relationForKey("rsvped")
        
         relation.query().findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                // There was an error
            } else {
                for each in objects {
                    var rsvpe = each as parseEvent
                    println("\(PFUser.currentUser().username) rsvped event(s) : \(rsvpe.EventName!)")
                }
            }
        }
    }
    @IBAction func ibeaconList(sender: AnyObject) {
        var ib = iBeacon.query() as PFQuery
        ib.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
        for obj in objects {
                var ibeacon = obj as iBeacon
                println("ibeacon is \(ibeacon.UUID)")
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEvent" {
            
        } else if segue.identifier == "toSignUp" {
        } else if segue.identifier == "toMyEvents" {
        } else {
        }

    }
    @IBAction func loginwithUser(sender: AnyObject) {
        loginToParse()
    }
    @IBAction func listallUsers(sender: AnyObject) {
        var query = parseUser.query()  

         query.findObjectsInBackgroundWithBlock { (allUsers:[AnyObject]!, error:NSError!) -> Void in
            
            for i in allUsers {
                var user = i as parseUser
                 println("user are \(user.username) and \(user.objectId), and screenname \(user.screenName!),  in zipcode \(user.zipcode!)")
            }
        }
    }
    @IBAction func listEvents(sender: AnyObject) {
        var events = parseEvent.query() as PFQuery
        events.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            for obj in objects {
              //  println(obj)
                var event = obj as parseEvent
                println("event name \(event.EventName!), id \(event.objectId) city: \(event.cityName!), max rsvp count:\(event.rsvpMax!)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "parse operation"
    }
    
    func loginToParse(){
        PFUser.logInWithUsernameInBackground("cindy", password:"password") {
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
