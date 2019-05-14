//
//  PopUpViewController.swift
//  TapAppDemo
//
//  Created by muddi hejjo on 03/05/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var parentVC:FirstViewController?
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func savePressed(_ sender: Any) {
        if let link = textfield.text {
            parentVC?.addLink(url: link)
        }
        parentVC?.dismiss(animated: true, completion: nil)
    }
    
}
