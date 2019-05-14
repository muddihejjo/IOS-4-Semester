//
//  SecondViewController.swift
//  TapAppDemo
//
//  Created by muddi hejjo on 30/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKNavigationDelegate {
    var getURL: TableViewCell = TableViewCell()
    var webView: WKWebView?
    var RecievedString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: RecievedString)!
        webView?.load(URLRequest(url: url))
    }
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        self.view = webView
    }
    



}

