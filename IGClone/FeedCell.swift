//
//  FeedCell.swift
//  IGClone
//
//  Created by Dustin Mahone on 7/29/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var postLikesLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Actions
    @IBAction func likeButtonPressed(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        let postRef = firestoreDatabase.collection("Posts")
        var likedByCurrentUser: Bool?
        var likedByArray: [String]?
        
        if let likeCount = Int(postLikesLabel.text!) {
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).getDocument { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let usersWhoLiked = snapshot?.get("LikedBy")
                let currentUser = Auth.auth().currentUser!.email
                
                if usersWhoLiked != nil {
                    likedByArray = usersWhoLiked as! [String]
                    if likedByArray!.contains(currentUser!) {
                        likedByCurrentUser = true
                    } else {
                        likedByCurrentUser = false
                    }
                    print(likedByCurrentUser)
                } else {
                    likedByCurrentUser = false
                }
                
                if likedByCurrentUser == false {
                    
                    let likes = ["likes" : likeCount + 1] as [String : Any]
                    let liked = ["LikedBy" : Auth.auth().currentUser!.email]
                    firestoreDatabase.collection("Posts").document(self.documentIdLabel.text!).setData(likes, merge: true)
                    firestoreDatabase.collection("Posts").document(self.documentIdLabel.text!).updateData(["LikedBy" : FieldValue.arrayUnion([Auth.auth().currentUser!.email])])
                    
                } else if likedByCurrentUser == true {
                    
                    let likes = ["likes" : likeCount - 1] as [String : Any]
                    let liked = ["LikedBy" : Auth.auth().currentUser!.email]
                    firestoreDatabase.collection("Posts").document(self.documentIdLabel.text!).setData(likes, merge: true)
                    firestoreDatabase.collection("Posts").document(self.documentIdLabel.text!).updateData(["LikedBy" : FieldValue.arrayRemove([Auth.auth().currentUser!.email])])
                    
                } else {
                    print("liked by current user is set to \(likedByCurrentUser)")
                }

            }
        }
            
             
        }
        
        
    }
    
}
