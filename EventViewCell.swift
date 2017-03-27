//
//  EventViewCell.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 26/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {
    
    //Outlet declarations
    @IBOutlet weak var titreEventLabel: UILabel!
    @IBOutlet weak var dateDebutEvent: UILabel!
    @IBOutlet weak var dateFinEvent: UILabel!
    @IBOutlet weak var noteEventLabel: UILabel!
    @IBOutlet weak var addCalendarButton: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
