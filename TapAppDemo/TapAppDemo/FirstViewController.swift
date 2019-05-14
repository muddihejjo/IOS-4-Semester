//
//  FirstViewController.swift
//  TapAppDemo
//
//  Created by muddi hejjo on 30/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//


import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    var links = [String]()
    var url  = URL(string: "https://dr.dk")
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        links.append("https://www.dr.dk")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? TableViewCell
        cell?.textLabel?.text = links[indexPath.row]
    
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupSegue" {
            let popVC = segue.destination as! PopUpViewController
            popVC.parentVC = self // so we can call the addLink method
            popVC.preferredContentSize = CGSize(width: 300, height: 300) //dynamic size
            popVC.presentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func addLink(url: String) {
        links.append(url)
        tableView.reloadData()
        
        //add link to array
    }
    
}

