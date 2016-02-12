//
//  BallParkMapView.swift
//  BallisLife
//
//  Created by Usman Shafique on 2/11/16.
//  Copyright © 2016 AAUS. All rights reserved.
//

import Foundation
import MapKit

extension ViewController {
    
    //let myLabel = UILabel(frame: CGRectMake(0, 0, 21, 21))
    //method that gets called for every annotation you add to the map
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //let myLabel = UILabel(frame: CGRectMake(0, 0, 21, 21))
        
        if let annotation = annotation as? BallParkAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            //map views are set up to reuse annotation views when some are no longer visible. So the code first checks to see if a reusable annotation view is available before creating a new one.
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                //use the plain vanilla MKAnnotationView class if an annotation view could not be dequeued. It uses the title and subtitle properties of your Artwork class to determine what to show in the callout – the little bubble that pops up when the user taps on the pin.
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.draggable = true
                view.enabled = true
                view.canShowCallout = true
                view.animatesDrop = true;
//                view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton(type: UIButtonType.InfoDark)
                view.rightCalloutAccessoryView = yesButton()
                
                //set label to display number of players
                let players = String(annotation.numberOfPlayers)
                myLabel.center = CGPointMake(160, 284)
                myLabel.textAlignment = NSTextAlignment.Left
                myLabel.text = players
                view.leftCalloutAccessoryView = myLabel
            }
            
            return view
        }
        return nil
    }
    
    //custom callout 
    
    func yesButton()-> UIButton  {
        
        let image = UIImage(named: "SoccerBall.JPG") as UIImage?
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(100, 100, 100, 100)
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: "didTapButton", forControlEvents: .PrimaryActionTriggered)
        return button
        
    }
    
    func didTapButton() {
        print ("Hey button worked")
        
        let alert = UIAlertController(title: "Soccer", message: "Wanna play?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes!", style: UIAlertActionStyle.Default, handler: { action in
            switch action.style{
            case .Default:
                print("default")
                print (self.myLabel.text)
                let players = Int(self.myLabel.text!)
                let newPlayers = players! + 1
                self.myLabel.text = String(newPlayers)
                //self.myLabel.text = "1"
                
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print ("ok nothing")
    }
}
