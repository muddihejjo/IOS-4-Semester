//
//  FirebaseService.swift
//  My Notebook
//
//  Created by muddi hejjo on 14/05/2019.
//  Copyright © 2019 Martin Løseth Jensen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseService {
    
let notesCollection = Firestore.firestore().collection("noter")
    
    let storage = Storage.storage() // service
    var storageRef:StorageReference?
    
    var notes = [Note]()
    
    func writeTextToDB(note:Note, document: DocumentReference) {
        document.setData(["text": note.text]) { error in
            if error != nil {
                print("error writing text to DB")
            }else {
                print("succes yes! DB")
            }
        }
    }
        
    

}

