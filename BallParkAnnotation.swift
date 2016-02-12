//
//  BallParkAnnotation.swift
//  BallisLife
//
//  Created by Usman Shafique on 2/11/16.
//  Copyright © 2016 AAUS. All rights reserved.
//

import Foundation
import MapKit

class BallParkAnnotation: NSObject, MKAnnotation {


    let title: String?
    let locationName: String?
    //MKAnnotation protocol requires a coordinate property
    let coordinate: CLLocationCoordinate2D
    let numberOfPlayers: Int
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D,
        numberOfPlayers: Int) {
            self.title = title
            self.locationName = locationName
            self.coordinate = coordinate
            self.numberOfPlayers = numberOfPlayers
            super.init()
    }
    
}