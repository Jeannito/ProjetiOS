//
//  SignUpViewController.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 02/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SignUpViewController: UIViewController, UIApplicationDelegate{

    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    
    @IBAction func signup(_ sender: Any) {
        var firstname = self.firstnameField.text
        var lastname = self.lastnameField.text
        var login = self.loginField.text
        var email = self.emailField.text
        var password = self.passwordField.text
        var confirmpassword = self.confirmpasswordField.text
        
        
        
    }
    
    
    
}
