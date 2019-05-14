//
//  ViewController.swift
//  MyNotebook
//
//  Created by muddi hejjo on 12/02/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    
   
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var button1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        if let message = defaults.string(forKey: "message"){
           text.text = message
        }else{
            text.text = "empty"
        }
    }
    
    
    
    @IBAction func tryMe(_ sender: Any) {
        saveText()
        
        print("pressed succesfully")
        
    }
    
    @IBAction func changeColorBG(_ sender: Any) {
    saveBG()
    }
    
    func saveBG(){
        
        //self.view.backgroundColor = UIColor.red
        
    }
    
    func saveText(){
        defaults.set(text.text, forKey: "message")
    }
    override func viewWillDisappear(_ animated: Bool) {
        saveText()
    }
    @IBAction func buttonTapped(_sender: Any){
        if self.view.backgroundColor == UIColor.white {
            
            self.view.backgroundColor = UIColor.red
            text.backgroundColor = UIColor.red
        }else if self.view.backgroundColor == UIColor.red {
            self.view.backgroundColor = UIColor.white
            text.backgroundColor = UIColor.white
        }
    }
    
}

