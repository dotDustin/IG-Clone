//
//  ViewController.swift
//  IGClone
//
//  Created by Dustin Mahone on 7/22/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Methods
    
    func signUpInErrorAlert(message: String) {
        let alert = UIAlertController(title: "Sign In/Sign Up Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Actions
    @IBAction func signInButtonPressed(_ sender: Any) {
        guard emailTextField.text != "" else { signUpInErrorAlert(message: "email empty")
            return
        }
        guard passwordTextField.text != "" else { signUpInErrorAlert(message: "password empty")
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authData, error) in
            
            if error != nil {
                self.signUpInErrorAlert(message: error?.localizedDescription ?? "login fail")
            } else {
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            }
            
        }
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard emailTextField.text != "" else { signUpInErrorAlert(message: "email empty")
            return
        }
        guard passwordTextField.text != "" else { signUpInErrorAlert(message: "password empty")
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authData, error) in
            
            if error != nil {
                self.signUpInErrorAlert(message: error?.localizedDescription ?? "database error")
            } else {
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            }
            
        }
        
    }
}

