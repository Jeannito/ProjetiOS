//
//  SendEventViewController.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 26/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class SendEventViewController: UIViewController {
    
    @IBOutlet weak var titleEventLabel: UITextField!
    @IBOutlet weak var dateDebutPicker: UIDatePicker!
    @IBOutlet weak var dateFinPicker: UIDatePicker!
    @IBOutlet weak var noteEvent: UITextView!

    @IBAction func dateDebutPickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        let dateDebut = dateDebutPicker.date
        
        
    }
    
    @IBAction func dateFinPickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        let dateFin = dateFinPicker.date
        
    }
    
    
    
    @IBAction func sendEvent(_ sender: Any) {
        
    }
    
}
