//
//  messageTableViewCell.swift
//  ChatApp
//
//  Created by Saranya Kalyanasundaram on 7/1/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var meAvatar: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var youAvatar: UIImageView!
    @IBOutlet var messageBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = (messageBubble.frame.size.height/5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
