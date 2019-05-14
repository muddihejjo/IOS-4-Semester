//
//  ViewController.swift
//  FilesInFirebase
//
//  Created by muddi hejjo on 19/03/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import FirebaseStorage
class ViewController: UIViewController {

    //referencestorage
    var storage:Storage?
    var storageRef: StorageReference?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage() //this is storage service
        storageRef = storage!.reference() //this is the root for all the files
        if let dogImage = UIImage(named: "dog.jpg"){
            uploadImage(image: dogImage, filename: "dog.jpg")
        }else{
            print("no dog found")
        }
        
        
    }
    
    
    
    
    @IBAction func DownloadImagePressed(_ sender: Any) {
        let imageRef = storage?.reference(withPath:"dog.jpg")
        imageRef?.getData(maxSize: 500000, completion: { (data, error) in
            if error != nil{
                print ("Failed to download \(error.debugDescription)")
            }else{
                print("succes in downloading image")
                let image = UIImage(data: data!)
                self.imageView.image = image
            }
    })
    }
    
    func uploadImage(image:UIImage, filename: String)  {
        let data = image.jpegData(compressionQuality: 1.0)
        let imageRef = storageRef?.child(filename)
        imageRef?.putData(data!, metadata: nil, completion: { (metadata, error) in
                //this runs AFTER Firebase is done saving, or whatever it does
                if error != nil{
                print ("Failed to upload \(error.debugDescription)")
                }else{
                    print("succes in uploading image")
                }
            }) //this is callback
    }
}
