//
//  SendFileViewController.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 27/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class SendFileViewController: UIViewController, UINavigationControllerDelegate{
    
    //Outlet
    @IBOutlet weak var nameLinkField: UITextField!
    @IBOutlet weak var linkField: UITextView!
    
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
    
    
    @IBAction func AddLink(_ sender: Any) {
        let link : ModelLink = ModelLink()
        
        link.sendLink(withName: nameLinkField.text!, withLink: linkField.text)
    }
    
    
    
    
}
