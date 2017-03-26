//
//  ProfilInformationViewController.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 22/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ProfilInformationViewController: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    let instance = Session.sharedInstance
    var user : ModelUser = ModelUser()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let information = user.getUsersByLogin(withLogin: self.instance.getLogin()!)
        firstnameLabel.text = information[0].prenom
        lastnameLabel.text = information[0].nom
        loginLabel.text = information[0].login
        mailLabel.text = information[0].email
        statusLabel.text = information[0].status
        promotionLabel.text = information[0].promotion
        yearLabel.text = information[0].annee
        
        if information[0].photo != nil{
            userPicture.image = UIImage(data: information[0].photo as! Data)
        } else {
            userPicture.image = UIImage(named: "user")
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteProfile(_ sender: Any) {
        user.deleteUserByLogin(withLogin: loginLabel.text!)
        Session.sharedInstance.endSession()
        CoreDataManager.save()
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
