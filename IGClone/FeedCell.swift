//
//  FeedCell.swift
//  IGClone
//
//  Created by Dustin Mahone on 7/29/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var postLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Actions
    @IBAction func likeButtonPressed(_ sender: Any) {
    }
    
}
