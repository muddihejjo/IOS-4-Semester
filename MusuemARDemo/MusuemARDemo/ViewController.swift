//
//  ViewController.swift
//  MusuemARDemo
//
//  Created by muddi hejjo on 07/05/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate{
let configuration = ARWorldTrackingConfiguration()
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
        
        configuration.detectionImages = referenceImages
        arskView.session.run(configuration)
    }
    @IBAction func returned(segue: UIStoryboardSegue) {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arskView.session.run(configuration)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arskView.session.pause()
        
    }
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        if let imageAnchor = anchor as? ARImageAnchor, let referenceImageName = imageAnchor.referenceImage.name {
            print("found image named: \(referenceImageName)")
            performSegue(withIdentifier: "segue1", sender: self)
            
        }
        return nil
    }

}

