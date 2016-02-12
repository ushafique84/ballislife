//
//  ViewController.swift
//  BallisLife
//
//  Created by Usman Shafique on 2/11/16.
//  Copyright © 2016 AAUS. All rights reserved.
//

import UIKit
//import to handle MKMapView
import MapKit
//import ability to locate current location of user
import CoreLocation

//set class to conform to mkmapview and cllocationmanager delegates
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // definelocaiton manager property
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the location manager to start finding current location as soon as view is loaded
        self.locationManager.delegate = self
        //setting it to accuracy best to get exact location
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //we want the request when only in use of app not when in background
        self.locationManager.requestWhenInUseAuthorization()
        //start looking for location
        self.locationManager.startUpdatingLocation()
        //display the blue dot for the current location
        self.mapView.showsUserLocation = true
        
        
        //handle long press to create annotation
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapView.addGestureRecognizer(lpgr)
        mapView.delegate = self
        
        
        //let ballPark = BallParkAnnotation(title: "Test", locationName: "Name", coordinate: CLLocationCoordinate2D, numberOfPlayers: <#T##Int#>)
        //mapView.addAnnotation(ballPark)
        //mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //implementing location delegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //location argument passed in. didUpdateLocation is called over and over again after startUPdatingLocation
        //, it's going to continually call this method
        //until we tell it stop so we are using the last one
        let location = locations.last
        //we're getting the center of above location to getting longitude/latitude from location above
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        //region is going to be a circle that we want the map to zoom too which is the MKCoordinateSpanMake. Bigger 
        //the number, the more it zooms out
        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
        //set the mapview to the region above so mapview goes to that region and zooms in and get zooming location
        self.mapView.setRegion(region, animated: true)
        //after we have the user's location, we can stop updating the location
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //print out errors if we get one with location manager
        print ("Errors: " + error.localizedDescription)
    }

    
    //function to handle long press recognizer
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Began {
            return
        }
        
        let touchPoint = gestureReconizer.locationInView(self.mapView)
        let touchMapCoordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        //get current location information
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
        var locationName: String!
        
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
        
            let placeArray = placemarks as [CLPlacemark]!
        
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            locationName = placeMark.addressDictionary?["Name"] as! String
            
        
            let parkAnnotation = BallParkAnnotation.init(title: locationName, locationName: "somelocation", coordinate: touchMapCoordinate, numberOfPlayers: 1)
        
            self.mapView.addAnnotation(parkAnnotation)
        }
        
    }

}

