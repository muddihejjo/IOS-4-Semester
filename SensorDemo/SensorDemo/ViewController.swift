//
//  ViewController.swift
//  SensorDemo
//
//  Created by muddi hejjo on 02/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var locationManager = CLLocationManager()
    let home = CLLocationCoordinate2D(latitude: 55.988094, longitude: 12.0047542 )
    override func viewDidLoad() {
        super.viewDidLoad()
         //55.988094,12.0047542
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("heading:", newHeading.trueHeading)
        let rad = degressToRadrians(degrees: newHeading.trueHeading)
        UIView.animate(withDuration: 0.5){ //seconds
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(rad))
        }
    }
    
    func degressToRadrians(degrees:Double) -> Double {
        return Double.pi * degrees / 180
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location: ", locations.first?.coordinate)
       
    }
    
}



