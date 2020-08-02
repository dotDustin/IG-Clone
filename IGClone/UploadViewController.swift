//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Dustin Mahone on 7/16/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        imageView.image = UIImage(named: "SelectImage.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image picker setup
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    // MARK:- Methods
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            fatalError("Image selection failed")
        }
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCaptionVC") {
            if let viewController = segue.destination as? CaptionViewController {
                viewController.selectedImage = imageView.image
            }
        }
    }
    
    // MARK:- Actions
    @IBAction func nextButtonPressed(_ sender: Any) {
        if imageView.image == UIImage(named: "SelectImage.png") {
            //do nothing
        } else {
            performSegue(withIdentifier: "toCaptionVC", sender: nil)
        }
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
}
