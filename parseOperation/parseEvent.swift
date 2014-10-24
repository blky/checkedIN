import Foundation


class parseEvent : PFObject,PFSubclassing {
    
    override class func load() {
        self.registerSubclass()
    }
    
    class  func  parseClassName() -> String! {
        return "Event"
    }
    override class func query() -> PFQuery! {
        return PFQuery(className: "Event")
    }
    
    var EventName:String? {
        get {return objectForKey("EventName") as String? }
        set {setObject(newValue, forKey: "EventName") }
    }
    var cityName:String? {
        get {return objectForKey("cityName") as String?}
        set {setObject(newValue, forKey: "cityName")}
    }
    
    var tagLine:String? {
        get {return objectForKey("tagLine") as String?}
        set {setObject(newValue, forKey: "tagLine")}
    }
    var rsvpMax:NSNumber? {
        get {return objectForKey("rsvpMax") as NSNumber?}
        set {setObject(newValue, forKey: "rsvpMax")}
    }
    

    
//    
//    var fromUser: ChatUser? {
//        get { return objectForKey("fromUser") as? ChatUser }
//        set { setObject(newValue, forKey: "toUser") }
//    }
//    var toUser: ChatUser? {
//        get { return objectForKey("toUser") as? ChatUser }
//        set { setObject(newValue, forKey: "fromUser") }
//    }
//    var image: PFFile? {
//        get { return objectForKey("image") as? PFFile }
//        set { setObject(newValue, forKey: "image") }
//    }
//    var phoneNumber : String? {
//        get { return objectForKey("additional") as String? }
//        set { setObject(newValue, forKey: "additional") }
//    }

    
}