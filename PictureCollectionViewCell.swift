//
//  PIctureTableViewCell.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    //Cell outlet
    @IBOutlet weak var picture: UIImageView!
    
    //Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
