//
//  ViewController.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 13/02/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    func saveNewPerson(withName name: String, password : String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alertError(errorMsg: "Could not sav person", userInfo: "unknow reason")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
    
    
        let user = User(context: context)
        user.login = name
        user.password = password
        do{
            /*try context.save()*/
        }
    }
    
    /*let user = saveNewPerson(ericko, taru34)*/
    
    @IBAction func log(_ sender: Any) {
        
    }
    
    func alertError(errorMsg error : String, userInfo user: String=""){
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(cancelAction)
        present(alert,animated:true)
    }
    
}

