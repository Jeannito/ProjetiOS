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

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    
    @IBOutlet weak var statusPicker: UIPickerView!
    
    let pickerData = ["Student","Teacher","Responsible"]
    
    var statusPicked: String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
    }
    
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String?
    {
        statusPicked = pickerData[row]
        return statusPicked
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        statusPicked = pickerData[statusPicker.selectedRow(inComponent: 0)]
    }

    
    override func didReceiveMemoryWarning()
    {
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
        let alertController = UIAlertController(title: "Success !", message: "Your sign up was successfull",  preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Connect", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any) {
        let firstname = self.firstnameField.text
        let lastname = self.lastnameField.text
        let login = self.loginField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let confirmpassword = self.confirmpasswordField.text
        let status = self.statusPicked
        
        if(password == confirmpassword)
        {
            let context = CoreDataManager.getContext()

            let user = User(context: context)

            user.prenom = firstname
            user.nom = lastname
            user.login = login
            user.password = password
            user.email = email
            user.status = status
        } else {
            self.Alert1()
        }
        
        self.Alert2()
        CoreDataManager.save()
    }
}
