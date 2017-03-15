//
//  HomeViewController.swift
//  ProjetiOS
//
//  Created by Erick Taru on 14/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var firstNames : [String] = ["Jeannot", "Erick"]
    var lastNames : [String] = ["B2R", "Taru"]
    var messages : [String] = ["Message 1", "Message 2"]
    
    @IBOutlet weak var messagesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.firstNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        cell.firstNameLabel.text = self.firstNames[indexPath.row]
        cell.lastNameLabel.text = self.lastNames[indexPath.row]
        cell.messageLabel.text = self.messages[indexPath.row]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func AlertEmpty() {
        let alertController = UIAlertController(title: "Empty Field", message:
            "You have to fill the message field... ^^", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok chef", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var MessageField: UITextField!
    
    @IBAction func sendAction(_ sender: Any) {
        let messageText = self.MessageField.text
        
        if(messageText != "")
        {
            let context = CoreDataManager.getContext()
            
            let message = Message(context: context)
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            let resultString = String(result)
            
            message.date = resultString
            message.idM = 1
            message.status = session?.getStatus()
            message.login = session?.getLogin()
            message.text = messageText
            
        } else {
            self.AlertEmpty()
        }
        
    }
    

}
