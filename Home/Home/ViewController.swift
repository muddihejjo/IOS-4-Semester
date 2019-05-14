//
//  ViewController.swift
//  Home
//
//  Created by muddi hejjo on 05/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//



import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
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

}

