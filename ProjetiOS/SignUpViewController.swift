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

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    //CoreData
    let context = CoreDataManager.getContext()
    
    //Variables in outlet
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var promotionField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    //Variables declaration
    var statusPicked: String?
    let pickerData = ["Student","Teacher","Manager", "Administration"]
    
    let picker = UIImagePickerController()
    
    let instance = Session.sharedInstance
    var users : ModelUser = ModelUser()
    
    //Action for getting pic from Library
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    //Action for take pic with camera
    @IBAction func takeAPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    //loaded info
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        statusPicked = pickerData[statusPicker.selectedRow(inComponent: 0)]
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //PickerView functions
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String?
    {
        statusPicked = pickerData[statusPicker.selectedRow(inComponent: 0)]
        return statusPicked
    }
    
    
    //ImagePicker functions
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        userPicture.contentMode = .scaleAspectFit //3
        userPicture.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func changeImage(sender: UITapGestureRecognizer){
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    //The segue for signUp
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //All conditions of sign up text field
        if identifier == "signUp" {
            //If some textfield is empty
            if ((firstnameField.text?.isEmpty)! || (lastnameField.text?.isEmpty)! || (loginField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (confirmpasswordField.text?.isEmpty)! || (promotionField.text?.isEmpty)! || (yearField.text?.isEmpty)!) {
                AlertManager.alert(view: self, WithTitle: "Empty field !", andMsg: "All fields must be filled !")
                return false
            }
            
            //If login already exist
            if (users.getUsersByLogin(withLogin: loginField.text!).count > 0) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Login already used !")
                return false
            }
            
            //If promotion isn't good
            if (promotionField.text != "IG" && promotionField.text != "GBA" && promotionField.text != "MI" && promotionField.text != "STE" && promotionField.text != "MAT" && promotionField.text != "MEA" && promotionField.text != "MSI" && promotionField.text != "EGC" && promotionField.text != "SE") {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Enter valid promotion !")
                return false
            }
            
            //If year isn't good
            if(yearField.text != "3" && yearField.text != "4" && yearField.text != "5") {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Enter valid year !")
                return false
            }
            
            //If the two password field doesn't match
            if(passwordField.text != confirmpasswordField.text) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Passwords do not match !")
                return false
            }
                
            else {
                return true
            }
            
        }
        
        return true
    }
    
    //Action sign up for register a user in the database
    //Sorry we know that we have to do it in the model but that's too late!
    @IBAction func signup(_ sender: Any) {
        
        let firstname = self.firstnameField.text
        let lastname = self.lastnameField.text
        let login = self.loginField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let confirmpassword = self.confirmpasswordField.text
        let status = self.statusPicked
        let photo = self.userPicture.image
        let promotion = self.promotionField.text
        let year = self.yearField.text
        
        //Conditions about sign up
        //The same than the segue
        if ((firstname?.isEmpty)! || (lastname?.isEmpty)! || (login?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)! || (confirmpassword?.isEmpty)! || (promotion?.isEmpty)! || (year?.isEmpty)!) {
            return
        }
        
        if (users.getUsersByLogin(withLogin: login!).count > 0) {
            return
        }
        
        if (promotion != "IG" && promotion != "GBA" && promotion != "MI" && promotion != "STE" && promotion != "MAT" && promotion != "MEA" && promotion != "MSI" && promotion != "EGC" && promotion != "SE") {
            return
        }
        
        if(year != "3" && year != "4" && year != "5") {
            return
        }
        
        if(password != confirmpassword) {
            return
        }
        
        //Get context
        let user = User(context: context)
        
        if photo != nil {
                
            let imageData = UIImageJPEGRepresentation(photo!, 0.6)
            user.photo = imageData! as NSData
        }
        
        //Registering in the database
        user.prenom = firstname
        user.nom = lastname
        user.login = login
        user.password = password
        user.email = email
        user.status = status
        user.promotion = promotion
        user.annee = year
        user.isConnected = false
        
        CoreDataManager.save()
         
    }
    
    @IBAction func `return`(_ sender: Any) {
        
    }
}
