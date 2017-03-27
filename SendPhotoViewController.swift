//
//  SendPhotoViewController.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//The class in popover for send a photo
class SendPhotoViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //Varibales
    let picker = UIImagePickerController()
    var statusPicked: String?
    
    //Outlet
    @IBOutlet weak var pictureView: UIImageView!

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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        pictureView.contentMode = .scaleAspectFit //3
        pictureView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Function sending a photo to the database and a message with the photo
    @IBAction func sendAPhoto(_ sender: Any) {
        if pictureView != nil{
            let context = CoreDataManager.getContext()
            
            //Get the data context
            let image = Image(context: context)
            
            //Prepare the date string
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
            let result = formatter.string(from: date)
            let resultString = String(result)
            let instance = Session.sharedInstance
        
            //Prepare image before send it in the database
            image.date = resultString
            image.sender = instance.getLogin()
            let photo = self.pictureView.image
            let imageData = UIImageJPEGRepresentation(photo!, 0.6)
            image.img = imageData! as NSData
            
            //Get the context
            let message = Message(context: context)
            
            //Sending the data in the database
            message.date = resultString
            message.status = instance.getStatus()
            message.sender = instance.getLogin()
            message.text = ""
            message.target = "All"
            
            message.img = imageData! as NSData
            
            //Save the context
            CoreDataManager.save()
        }
    }
}
