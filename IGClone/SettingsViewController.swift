//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Dustin Mahone on 7/16/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("sign out fail")
        }
        
    }

}
