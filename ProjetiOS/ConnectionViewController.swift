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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func AlertPassword() {
        let alertController = UIAlertController(title: "Password Error", message:
            "Your password is missing, fill it!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func AlertLogin() {
        let alertController = UIAlertController(title: "Login missing", message:
            "Your login is missing, fill it!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func AlertPasswordWrong() {
        let alertController = UIAlertController(title: "Wrong password", message:
            "Your password is wrong!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func AlertLoginWrong() {
        let alertController = UIAlertController(title: "Wrong login", message:
            "Your login is wrong!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    @IBAction func log(_ sender: Any) {
        let password = self.passwordField.text
        let login = self.loginField.text
        
        if(password==""){
            AlertPassword()
        } else if(login==""){
            AlertLogin()
        } else {
            let listLogin = user.getUsersByLogin(withLogin: login!)
            if (listLogin.count==0){
                AlertLoginWrong()
            }
            else if(listLogin[0].password == password){
                Session.sharedInstance.setLogin(login: listLogin[0].login!)
                Session.sharedInstance.setStatus(status: listLogin[0].status!)
            } else {
                AlertPasswordWrong()
            }
            
        }
        
    }

}
