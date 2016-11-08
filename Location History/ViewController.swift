//
//  ViewController.swift
//  Location History
//
//  Created by hostname on 10/20/16.
//  Copyright © 2016 notungood. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    // Outlet for fullscreen map
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBAction func addLocationTapped(_ sender: AnyObject) {
        let coord = locationManager.location?.coordinate
        
        if let lat = coord?.latitude {
            if let long = coord?.longitude {
                DataStore().storeDataPoint(latitude: String(lat), longitude: String(long))
            }
        }
        
    }
    
    
    // Manager needs to globally accessible to view, so not in viewDidLoad
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location manager functions should be performed in ViewController, because it is the class that inherits from CLLocationManagerDelegate
        locationManager.delegate = self
        
        // Ask and then update location upon loading
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //
        if let oldCoordinates = DataStore().getLastLocation() {
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Double(oldCoordinates.latitude)!
            annotation.coordinate.longitude = Double(oldCoordinates.longitude)!
            
            annotation.title = "Previous Location"
            annotation.subtitle = (String(oldCoordinates.latitude) + ":" + String(oldCoordinates.longitude))
            myMapView.addAnnotation(annotation)
        }
    }

    // Update map or display warning upon change of location authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            // In practice, this would be a message to the user, rather than printed to the console.
            print("The app won't work without access to your location.")
            return
        }
        
        // Update map when location access is granted
        print("Location access granted, thanks.")
        myMapView.showsUserLocation = true
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

