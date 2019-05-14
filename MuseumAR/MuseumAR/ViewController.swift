//
//  ViewController.swift
//  MuseumAR
//
//  Created by muddi hejjo on 07/05/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

//1. delegate
//2.
//


import UIKit
import ARKit


class ViewController: UIViewController, ARSKViewDelegate {

    
    @IBOutlet weak var arskView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    arskView.delegate = self
    arskView.showsFPS = true
        if let scene = SKScene(fileNamed: "MyScene"){
            arskView.presentScene(scene)
        }
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
            else {
                fatalError("no image found for ARWoldTrackingConfiguration")
        }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        arskView.session.run(configuration)
        
    }


}

