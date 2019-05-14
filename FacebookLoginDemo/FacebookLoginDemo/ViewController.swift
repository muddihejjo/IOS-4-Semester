//
//  ViewController.swift
//  FacebookLoginDemo
//
//  Created by muddi hejjo on 23/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var imageViewView: UIImageView!
    
    @IBOutlet weak var facebookStatus: UILabel!
    @IBOutlet weak var firebaseStatus: UILabel!
    @IBAction func FacebookLoginPressed(_ sender: Any) {
        
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, ReadPermission.email], viewController: self) { (result) in
            switch result {
            case .cancelled :
                print("user cancelled the login request")
                break
            case .failed(let error):
                print("login failed because of \(error.localizedDescription)")
                break
            case .success(grantedPermissions: let granted, declinedPermissions: let declined, token: let token):
                print("Login was successful with user: \(String(describing: token.userId.debugDescription))")
                // Login to firebase
                let credential = FacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
                
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                    if error == nil {
                        print("successfull login to firebase \(result.debugDescription)")
                        DispatchQueue.main.async {
                            self.firebaseStatus.backgroundColor = UIColor.green
                        }
                    }
                })
                
                
                // call facebook api to get user email and profile photo
                
                self.showUserInfo(token: token)
                self.facebookStatus.backgroundColor = UIColor.green
                break
            }
        }
    }
    
    func showUserInfo(token: AccessToken) {
        //1. build a query
        let connection = GraphRequestConnection()
        let request = GraphRequest(graphPath: "/me", parameters: ["fields":"id, email, picture.type(large)"], accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)
        connection.add(request) { response, result in
            
            switch result {
            case .success(response: let response):
                print("response: \(response)")
                if let email = response.dictionaryValue!["email"]{
                    print("email is \(email)")
                    if let picture = response.dictionaryValue!["picture"] as? [String: Any],
                        let data = picture["data"] as? [String:Any],
                        let url = data["url"] as? String {
                        let urlObject = URL(string: url)
                        self.imageViewView.load(url: urlObject!) //maybe queue issue
                        print(url)
                    
                    }
                    
                    
                }
                
                break
            case .failed(let error):
                print("error: \(error.localizedDescription)")
            }
        }
        
        
        
        //2. execute query
        
        
        connection.start()
        
    }
    
        
}

extension UIImageView {
    func load (url: URL) {
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data (contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
        }
        }
    }
}
}
}






