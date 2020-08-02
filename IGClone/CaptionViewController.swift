//
//  CaptionViewController.swift
//  IGClone
//
//  Created by Dustin Mahone on 7/27/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Firebase

class CaptionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Constants and Variables
    var selectedImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage
        
    }
    
    // MARK:- Methods
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Actions
    @IBAction func sharebuttonPressed(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 1.0) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.alertView(title: "Error", message: error?.localizedDescription ?? "Upload Error")
                    
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            // Firestore
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference: DocumentReference? = nil
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.textField.text, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.alertView(title: "Error", message: error?.localizedDescription ?? "database error")
                                } else {
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
        
    }
    
}
