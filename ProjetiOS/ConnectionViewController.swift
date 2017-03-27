//
//  ConnectionViewController.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 08/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ConnectionViewController: UIViewController {
    
    //Variable - retrieve user info from model
    var user : ModelUser = ModelUser()

    //outlets
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //overridden function to manage error and alerts
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "login" {
            
            //if a field is empty
            if ((loginField.text?.isEmpty)! || (passwordField.text?.isEmpty)!) {
                AlertManager.alert(view: self, WithTitle: "Empty field !", andMsg: "All fields must be filled !")
                return false //prevents segue from performing
            }
            
            //if login is not in the database
            if (user.getUsersByLogin(withLogin: loginField.text!).count == 0) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Invalid login !")
                return false
            }
            
            // if passwords don't match
            let checkPassword = user.getUsersByLogin(withLogin: loginField.text!)
                
            if(checkPassword[0].password != passwordField.text) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Invalid password !")
                return false
            }
                
            else {
                return true
            }
            
        }
        
        return true
    }
    
    //Action - login button
    @IBAction func log(_ sender: Any) {
        
        //retrieve users
        let userInfo = user.getUsersByLogin(withLogin: loginField.text!)
        
        //condition to manage login errors
        if(user.getUsersByLogin(withLogin: loginField.text!).count == 0) {
            Session.sharedInstance.endSession()
        }
        else {
            //connection is cleared, session starts
            Session.sharedInstance.setLogin(login: userInfo[0].login!)
            Session.sharedInstance.setStatus(status: userInfo[0].status!)
            userInfo[0].isConnected = true
        }
        
    }
        
}

