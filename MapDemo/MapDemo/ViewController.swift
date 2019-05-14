//
//  ViewController.swift
//  MapDemo
//
//  Created by muddi hejjo on 26/02/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import MapKit //for map reference
import CoreLocation //

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()//ask permission from the user
        locationManager.startUpdatingLocation() //close whenever you like to
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location\(locations.first)")
        
        if let coord = locations.first?.coordinate {
            print("current coordinate\(coord)")
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 400, longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case.authorizedWhenInUse:
            mapView.showsUserLocation = true
        default:
            mapView.showsUserLocation = false
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    
    
    @IBAction func longPressPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let gpsCoord = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
            print("long pressed \(gpsCoord)")
            let annotation = MKPointAnnotation()
            annotation.coordinate = gpsCoord
            mapView.addAnnotation(annotation)
            
            //Create alert
            let alert = UIAlertController(title: "New annotation", message: "Enter annotation title", preferredStyle: .alert)
            //Create textfield
            alert.addTextField {
                (textField) in
                textField.placeholder = "Title"
            }
            
            
 
            
           
        
            //Cancel button action
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
                print("Cancel")
            }))
            
            //Accept button action
            alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields?[0]
                //let textFieldPass = alert?.textFields![1]
                print("Text field: \(textField?.text)")
                //print("Text field: \(textFieldPass!.text)")
                //self.Authentication(usuario: textField!.text!, clave: //textFieldPass!.text!)
                annotation.title = textField?.text
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
 
    }
    
}

