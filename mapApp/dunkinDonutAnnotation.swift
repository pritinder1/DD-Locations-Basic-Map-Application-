//
//  dunkinDonutAnnotation.swift
//  mapApp
//
//  Created by Pritinder Singh  on 7/2/16.
//  Copyright © 2016 Pritinder Singh . All rights reserved.
//

import Foundation
import MapKit


class dunkinDonutAnnotation: NSObject, MKAnnotation {

    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D){
    
        self.coordinate = coordinate
    }

}
