//
//  SecondViewController.swift
//  mapApp
//
//  Created by Pritinder Singh  on 7/2/16.
//  Copyright © 2016 Pritinder Singh . All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManger = CLLocationManager()
    
    
    let addresses = [
    
        "973 Route 9 North, South Amboy, NJ 08879",
        "1076 Route 9, Old Bridge, NJ 08857",
        "974 Route 9 South, Sayreville, NJ 08879",
        "528 Raritan St, Sayreville, NJ 08872",
        "139-145 Broadway, South Amboy, NJ 08879"

    ]
    
    let regionRadius = 1200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    
        
        for add in addresses {
        
            getPlacemarkFromAddress(add)
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        locationAuthStatus()
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func locationAuthStatus(){
    
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
        
            map.showsUserLocation = true
        }else {
        
        
            locationManger.requestWhenInUseAuthorization()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(dunkinDonutAnnotation){
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.blueColor()
            annoView.animatesDrop = true
            return annoView
        
        }else if annotation.isKindOfClass(MKUserLocation){
        
            return nil

        
        }
        
        return nil
    }
    
    func centerMapOnLocation(location: CLLocation){
    
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
            map.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
        
            centerMapOnLocation(loc)
        }
    }
    
    
    func createAnnotationForLocation(location: CLLocation){
        let dunkin = dunkinDonutAnnotation(coordinate: location.coordinate)
        
        map.addAnnotation(dunkin)
    }
    
    
    func getPlacemarkFromAddress(address: String){
    
    
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location{
                    
                    self.createAnnotationForLocation(loc)
                    
                }
            }
        
        
        }
    }


}

