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

class ProfilInformationViewController: UIViewController {
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    let instance = Session.sharedInstance

    @IBAction func deleteUser(_ sender: Any) {
        User.deleteUser(withLogin: instance.getLogin()!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let information = User.getUsersByLogin(withLogin: self.instance.getLogin()!)
        firstnameLabel.text = information[0].prenom
        lastnameLabel.text = information[0].nom
        loginLabel.text = information[0].login
        mailLabel.text = information[0].email
        statusLabel.text = information[0].status
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
