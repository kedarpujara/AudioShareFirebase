//
//  FeedCell.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/27/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    
    @IBAction func likePressed(_ sender: Any) {
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
