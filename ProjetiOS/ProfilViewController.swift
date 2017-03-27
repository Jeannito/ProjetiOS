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

class ProfilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //CoreData
    let context = CoreDataManager.getContext()
    
    //Outlet
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    @IBOutlet weak var userPicture: UIImageView!
    
    //Varibales
    let instance = Session.sharedInstance
    var user : ModelUser = ModelUser()
    
    let picker = UIImagePickerController()
    
    //Function to take a photo from library
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    //Function to take a photo from camera
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
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
        loginField.text = information[0].login
        emailField.text = information[0].email
        userPicture.image = UIImage(data: information[0].photo as! Data)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The segue for the modify button
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //Some conditions about the update textfield
        if identifier == "update" {
            
            if (((loginField.text?.isEmpty)! || (emailField.text?.isEmpty)!)) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Login and email must be filled !")
                return false
            }
            
            if (user.getUsersByLogin(withLogin: loginField.text!).count > 0 && loginField.text! != Session.sharedInstance.login) {
                AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Login already used !")
                return false
            }
            
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
    
    //The action of the modify button
    //We know that the bad thing to do it here but we have no more time to do it, sorry...
    @IBAction func modify(_ sender: Any) {
        
        let login = self.loginField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let confirmpassword = self.confirmpasswordField.text
        let photo = self.userPicture.image
        
        //Some conditions about modify
        if (((login?.isEmpty)! || (email?.isEmpty)!)) {
            return
        }
        
        if (user.getUsersByLogin(withLogin: loginField.text!).count > 0 && loginField.text! != Session.sharedInstance.login) {
            return
        }
        
        if(password != confirmpassword) {
            return
        }
        
        let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
            
        if photo != nil {
                
            let imageData = UIImageJPEGRepresentation(photo!, 0.6)
            information[0].photo = imageData! as NSData
        }
            
        //Add user information in the database
        information[0].login = login
        information[0].email = email
        if(password != ""){
            information[0].password = password
        }
        
        Session.sharedInstance.setLogin(login: login!)
            
        CoreDataManager.save()
        
    }
    
    @IBAction func `return`(_ sender: Any) {
        
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

    
    //Picker function
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
}
