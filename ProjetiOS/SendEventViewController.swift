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

class SendEventViewController: UIViewController, UINavigationControllerDelegate{
    
    //Declare variables
    var dateDebut : Date? = nil
    var dateFin : Date? = nil
    
    //Outlets
    @IBOutlet weak var titleEventLabel: UITextField!
    @IBOutlet weak var dateDebutPicker: UIDatePicker!
    @IBOutlet weak var dateFinPicker: UIDatePicker!
    @IBOutlet weak var noteEvent: UITextView!

    
    
    //loaded info
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Segue for the button add event
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //A condition about the event textfield
        if identifier == "addEvent" {
            if (noteEvent.text.isEmpty || (titleEventLabel.text?.isEmpty)!) {
                AlertManager.alert(view: self, WithTitle: "Fill all the field", andMsg: "You have to fill all the field before continue")
                return false
            }
            else{
                return true
            }
        }
        return true
    }
    
    //The action getting the date from a picker
    @IBAction func dateDebutPickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        self.dateDebut = dateDebutPicker.date
        
        
    }
    
    //The action getting the date from a picker
    @IBAction func dateFinPickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        self.dateFin = dateFinPicker.date
        
    }
    
    
    //The action sending an event in the database
    @IBAction func sendEvent(_ sender: Any){
        if(dateDebut == nil){
            self.dateDebut = Date()
        }
        if(dateFin == nil){
            self.dateFin = Date()
        }
        
        let eventFetched : ModelEvent=ModelEvent()
        if (noteEvent.text.isEmpty || (titleEventLabel.text?.isEmpty)!) {
            return
        }
        eventFetched.sendEvent(withTitle: titleEventLabel.text!, withNote: noteEvent.text!, withDateDebut: dateDebut!, withDateFin: dateFin!)
    }
    
}
