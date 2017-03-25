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

    let context = CoreDataManager.getContext()
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
    @IBOutlet weak var userPicture: UIImageView!
    
    let instance = Session.sharedInstance
    var user : ModelUser = ModelUser()
    
    let picker = UIImagePickerController()
    
    @IBAction func photoFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
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
    
    @IBAction func modify(_ sender: Any) {
        let login = self.loginField.text
        let email = self.emailField.text
        let password = self.passwordField.text
        let confirmpassword = self.confirmpasswordField.text
        let photo = self.userPicture.image
        
        if(password == confirmpassword)
        {
            let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
            
            if photo != nil {
                
                let imageData = UIImageJPEGRepresentation(photo!, 0.6)
                information[0].photo = imageData! as NSData
            }
            
            
            information[0].login = login
            information[0].email = email
            information[0].password = password
            
            
            Session.sharedInstance.setLogin(login: login!)
            
            self.performSegue(withIdentifier: "modifyOk", sender: self)
            
            CoreDataManager.save()
            
            
        } else {
            self.Alert1()
        }
        
    }
    
    @IBAction func `return`(_ sender: Any) {
        
    }
    

    
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

    
    //MARK: - Delegates
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
