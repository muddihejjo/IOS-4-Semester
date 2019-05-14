//
//  ViewController.swift
//  HomeCompass
//
//  Created by Martin Løseth Jensen on 05/04/2019.
//  Copyright © 2019 Martin Løseth Jensen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var compassImageView: UIImageView!

    let home = CLLocationCoordinate2D(latitude: 55.6608014, longitude: 12.5963371)
    var locationManager = CLLocationManager()
    var lastBearing = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        UIView.animate(withDuration: 0.5) {
            //print("Heading: ", newHeading.trueHeading)
            let angle = self.degreeToRadian(degrees: newHeading.trueHeading)
            self.compassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-(angle)))
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(-(self.lastBearing - angle)))
        }
    }

    func degreeToRadian(degrees: Double) -> Double {
        return Double.pi * degrees / 180.0
    }

    func radiansToDegrees(rad: Double) -> Double {
        return 180.0 * rad / Double.pi
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location: ", locations.first?.coordinate as Any)
        let location = locations.first?.coordinate

        let bearing = angleFromCoordinate(latitude1: location!.latitude, longitude1: location!.longitude,
                latitude2: home.latitude, longitude2: home.longitude)
        print("Bearing: ", bearing)
        lastBearing = bearing

        let angle = radiansToDegrees(rad: bearing)

        UIView.animate(withDuration: 0.5) {
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(-(self.lastBearing - angle)))
        }
    }

    func angleFromCoordinate(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let dLon = (longitude2 - longitude1)
        let y = sin(dLon) * cos(latitude2)
        let x = cos(latitude1) * sin(latitude2) - sin(latitude1) * cos(latitude2) * cos(dLon)

        var brng = atan2(y, x)

        return brng
    }
}

