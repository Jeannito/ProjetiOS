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
    
    @IBOutlet weak var messagesTable: UITableView!
    
    var message = Message.getAllMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        
        
        cell.loginLabel.text = self.message[indexPath.row].sender
        cell.messageLabel.text = self.message[indexPath.row].text
 
        return cell
    }
    
    func refreshMsg(){
        self.message=Message.getAllMessage()
    }
    
    /*
    // MARK: - Navigationself.firstNames[indexPath.row]

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
            Message.sendMessage(withMessage: messageText!)
            self.refreshMsg()
            
        } else {
            self.AlertEmpty()
        }
        
        
    }
    
}
