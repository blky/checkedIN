import Foundation


class parseEvent : PFObject,PFSubclassing {
    
    var _geoLocation: CLLocation?
    
    override class func load() {
        self.registerSubclass()
    }
    class func parseClassName() -> String! {
        return "Event"
    }
    override class func query() -> PFQuery! {
        return PFQuery(className: "Event")
    }
    var EventName:String? {
        get {return objectForKey("EventName") as String? }
        set {setObject(newValue, forKey: "EventName") }
    }
    var streetAddress:String? {
        get {return objectForKey("streetAddress") as String?}
        set {setObject(newValue, forKey: "streetAddress")}
    }
    var cityName:String? {
        get {return objectForKey("cityName") as String?}
        set {setObject(newValue, forKey: "cityName")}
    }
    var state:String? {
        get {return objectForKey("State") as String?}
        set {setObject(newValue, forKey: "State")}
    }
    var zipCode:String? {
        get {return objectForKey("zipCode") as String?}
        set {setObject(newValue, forKey: "zipCode")}
    }
    var tagLine:String? {
        get {return objectForKey("tagLine") as String?}
        set {setObject(newValue, forKey: "tagLine")}
    }
    var eventDetail:String? {
        get {return objectForKey("eventDetail") as String?}
        set {setObject(newValue, forKey: "eventDetail")}
    }
    var rsvpMax:NSNumber? {
        get {return objectForKey("rsvpMax") as NSNumber?}
        set {setObject(newValue, forKey: "rsvpMax")}
    }
    var rsvpCount:NSNumber? {
        get {return objectForKey("rsvpCount") as NSNumber?}
        set {setObject(newValue, forKey: "rsvpCount")}
    }
    var eventDate:NSDate? {
        get {return objectForKey("EventDate") as NSDate?}
        set {setObject(newValue, forKey: "EventDate")}
    }
    var eventProfileImage:PFFile? {
        get {return objectForKey("eventProfileImg") as? PFFile}
        set {setObject(newValue, forKey: "eventProfileImage")}
    }
    var fullAddress: String? {
        get {
            return self.streetAddress! + "," +    self.cityName! + "," + self.state! + " " + self.zipCode!

        }
    }

    
   
}