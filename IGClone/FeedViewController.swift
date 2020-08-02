//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Dustin Mahone on 7/16/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constants and Variables
    
    var postedByArray = [String]()
    var postCommentArray = [String]()
    var likesArray = [Int]()
    var imageUrlArray = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func getData() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true {
                    
                    self.postedByArray.removeAll(keepingCapacity: false)
                    self.postCommentArray.removeAll(keepingCapacity: false)
                    self.likesArray.removeAll(keepingCapacity: false)
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        //let documentID = document.documentID
                        //print(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.postedByArray.append(postedBy)
                        }

                        if let postComment = document.get("postComment") as? String {
                            self.postCommentArray.append(postComment)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likesArray.append(likes)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postedByArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
        cell.userLabel.text = postedByArray[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]))
        cell.postCommentLabel.text = postCommentArray[indexPath.row]
        cell.postLikesLabel.text = "\(likesArray[indexPath.row])"
        
        return cell
    }


}
