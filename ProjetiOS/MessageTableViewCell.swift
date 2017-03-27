//
//  MessageTableViewCell.swift
//  ProjetiOS
//
//  Created by Erick Taru on 14/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    //Outlet declaration
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var isConnectedImage: UIImageView!
    @IBOutlet weak var isNotConnectedImage: UIImageView!

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
