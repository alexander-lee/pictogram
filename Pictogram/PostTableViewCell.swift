//
//  PostTableViewCell.swift
//  Pictogram
//
//  Created by Alexander on 10/18/16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post! {
        didSet {
            self.postImageView.file = post.media
            self.captionLabel.text = post.caption
            self.postImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
