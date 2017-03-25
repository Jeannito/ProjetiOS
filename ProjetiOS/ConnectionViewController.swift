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
    
    var user : ModelUser = ModelUser()

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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "login" {
            
            if ((loginField.text?.isEmpty)! || (passwordField.text?.isEmpty)!) {
                AlertManager.alert(view: self, WithTitle: "Empty field !", andMsg: "All fields must be filled !")
                return false
            }
            
            if (user.getUsersByLogin(withLogin: loginField.text!).count == 0) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Invalid login !")
                return false
            }
            
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
    
    @IBAction func log(_ sender: Any) {
        
        let userInfo = user.getUsersByLogin(withLogin: loginField.text!)
        
        if(user.getUsersByLogin(withLogin: loginField.text!).count == 0) {
            Session.sharedInstance.endSession()
        }
        else {
            Session.sharedInstance.setLogin(login: userInfo[0].login!)
            Session.sharedInstance.setStatus(status: userInfo[0].status!)
        }
        
    }
        
}

