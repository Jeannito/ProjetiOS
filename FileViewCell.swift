//
//  FileTableCell.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 27/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit

class FileViewCell: UITableViewCell {
    
    //Outlet declarations
    @IBOutlet weak var nameFileLabel: UILabel!
    @IBOutlet weak var linkLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
