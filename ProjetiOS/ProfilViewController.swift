//
//  ProfilViewController.swift
//  ProjetiOS
//
//  Created by Erick Taru on 21/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ProfilViewController: UIViewController {

    let context = CoreDataManager.getContext()
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    
    let instance = Session.sharedInstance
    var user : ModelUser = ModelUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
        loginField.text = information[0].login
        emailField.text = information[0].email
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Alert1() {
        let alertController = UIAlertController(title: "Password Error", message:
            "Your passwords are different", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func Alert2() {
        let alertController = UIAlertController(title: "Success !", message: "Your profile has been updated !",  preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func modify(_ sender: Any) {
        let login = self.loginField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let confirmpassword = self.confirmpasswordField.text
        
        if(password == confirmpassword)
        {
            
            let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
            
            
            information[0].login = login
            information[0].email = email
            information[0].password = password
            
            Session.sharedInstance.setLogin(login: login!)
            
            self.Alert2()
            
            CoreDataManager.save()
            
             self.performSegue(withIdentifier: "modify", sender: self)
            
        } else {
            self.Alert1()
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
