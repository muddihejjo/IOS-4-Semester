//
//  ViewController.swift
//  ARCDemo
//
//  Created by muddi hejjo on 12/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show red", style: .plain, target: self, action: #selector(handleShowRedController))
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "someName"), object: nil)
        }
    }
    
    @objc func handleShowRedController() {
        navigationController?.pushViewController(redController(), animated: true)
    }
    
    class redController: UITableViewController {
        deinit {
            print("redController just deinitialized")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.backgroundColor = .red
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "someName"), object: nil, queue: .main) { [weak self](Notification) in
                self?.showAlert()
            }
        
        }
    
    func showAlert(){
        let alertController = UIAlertController(title: "hi there", message: "whats up", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
        }
    }


}

