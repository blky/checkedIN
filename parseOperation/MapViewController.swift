//
//  MapViewController.swift
//  parseOperation
//
//  Created by Cindy Zheng on 10/30/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate  {
     @IBOutlet weak var mapView: MKMapView!
    
    var events:[parseEvent]?
    var geoLocations: [CLLocation]?
    var annotations: Array<MKPointAnnotation>!
    var center: CLLocationCoordinate2D!

    @IBAction func Done(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        fetechAllEvents()
        
        let myLocation = CLLocation(latitude: 37.4201828357191,longitude: -122.2141283997882)
        //self.mapView.centerCoordinate = myLocation.coordinate
        //self.mapView.selectAnnotation(pointAnnotation, animated: true)
        
        let center = myLocation.coordinate
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: center, span: self.mapView.region.span)
        
        self.mapView.setRegion(region, animated: true )
        self.mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
        
        
    }
    
    func fetechAllEvents(){
        var events = parseEvent.query() as PFQuery
        events.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.events = objects as? Array
            
            for obj in objects {
                var event = obj as parseEvent
                self.addAnotation(event)
            }
          
        }

    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view!.canShowCallout = true
            view!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
        }
        return view
    }
//    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        let index = (self.annotations as NSArray).indexOfObject(view.annotation)
//        if index >= 0 {
//            self.showDetailsForResult(self.results[index])
//        }
//    }
    
    
    func addAnotation(event:parseEvent)   {
        var geoLocation:CLLocation?
        var geocoder:CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(event.fullAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
        if error != nil {
            println("geolocation Error", error)
        }
        else {
             if let placemark = placemarks?[0] as? CLPlacemark {
                var placemark:CLPlacemark = placemarks[0] as CLPlacemark
                let lat = placemark.location.coordinate.latitude
                let long = placemark.location.coordinate.longitude
                let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                pointAnnotation.title = event.EventName
                
                self.mapView.addAnnotation(pointAnnotation)
        
            }
        }
        
        })

    }
    
    
    
    func singleAnnotation(){
        //address is :2875 Sand Hill Rd, Menlo Park, CA 94025, coordinates: 37.4201828357191 + -122.2141283997882
        var restaurantAddress = "2875 Sand Hill Rd, Menlo Park, CA 94025"
        var geocoder:CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurantAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                println("Error", error)
            }
            else if let placemark = placemarks?[0] as? CLPlacemark {
                
                var placemark:CLPlacemark = placemarks[0] as CLPlacemark
                
                let lat = placemark.location.coordinate.latitude
                let long = placemark.location.coordinate.longitude
                
                let cllocation = CLLocation(latitude: lat, longitude: long)
                //apple head quarter
                let myLocation = CLLocation(latitude: 37.4201828357191,longitude: -122.2141283997882)
                //            let distance = myLocation.distanceFromLocation(cllocation)/1000 * 0.6
                //            let distanceF = String(format: "%.1f mi", distance )
                //             self.labelDistance.text = distanceF
                var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                pointAnnotation.title = "Apple HQ"
                
                self.mapView.addAnnotation(pointAnnotation)
                self.mapView.centerCoordinate = myLocation.coordinate
                self.mapView.selectAnnotation(pointAnnotation, animated: true)
                
                
                let center = myLocation.coordinate
                
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: center, span: self.mapView.region.span)
                self.mapView.setRegion(region, animated: true )
                self.mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
                
                //           let region = self.mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(center, 1500, 1500))
                //           self.mapView.setRegion(region, animated: true )
                println("Added annotation to map view")
            }
        })
    }
}

