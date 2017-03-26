//
//  HomeViewController.swift
//  ProjetiOS
//
//  Created by Erick Taru on 14/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var messagesTable: UITableView!
    
    var userFetched : ModelUser = ModelUser()
    var msgFetched : ModelMessage = ModelMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.msgFetched.getMessages().delegate = self
        self.msgFetched.refreshMsg()
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.performSegue(withIdentifier: "deconnect", sender: self)
        Session.sharedInstance.endSession()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.msgFetched.getNumberMessages()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        var user = userFetched.getUsersByLogin(withLogin: Session.sharedInstance.getLogin()!)
        
        let message = self.msgFetched.getMessages().object(at: indexPath)
        
        cell.dateLabel.text = message.date
        cell.loginLabel.text = message.sender
        if message.img != nil{
            cell.imgMessage.image = UIImage(data: message.img as! Data)
            cell.messageLabel.text = nil
        } else {
            cell.imgMessage.image = nil
            cell.messageLabel.text = message.text
        }

        if user[0].photo != nil {
            var thesender = userFetched.getUsersByLogin(withLogin: message.sender!)
            cell.userPicture.image = UIImage(data: thesender[0].photo as! Data)
        } else {
            cell.userPicture.image = UIImage(named: "user")
        }
 
        return cell
    }
    
    
    // MARK: - NSFetchResultController delegate protocol
    
    /// Start the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messagesTable.beginUpdates()
    }
    
    /// End the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messagesTable.endUpdates()
        self.messagesTable.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath{
                self.messagesTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.messagesTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
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
            msgFetched.sendMessage(withMessage: messageText!)
            
            
        } else {
            self.AlertEmpty()
        }
        self.viewDidLoad()
        
    }
    
}
