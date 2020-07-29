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
    
    @IBAction func sharebuttonPressed(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.2) {
            let imageReference = mediaFolder.child("image.jpeg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                }
            }
        }
    }
    
}
