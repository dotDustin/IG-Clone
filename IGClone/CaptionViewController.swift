//
//  CaptionViewController.swift
//  IGClone
//
//  Created by Dustin Mahone on 7/27/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

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
    
}
