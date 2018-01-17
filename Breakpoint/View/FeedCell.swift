//
//  FeedCell.swift
//  Breakpoint
//
//  Created by Fabio Quintanilha on 1/16/18.
//  Copyright © 2018 FabioQuint. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
    func configCell(profileImage: UIImage, email: String, content: String) {
        
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content        
    }

}
