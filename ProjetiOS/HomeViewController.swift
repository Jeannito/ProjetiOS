//
//  HomeViewController.swift
//  ProjetiOS
//
//  Created by Erick Taru on 14/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var messagesTable: UITableView!
    
    var groupPicked: String?
    let pickerData = ["All", "Student","Teacher","Manager", "Administration"]
    
    var userFetched : ModelUser = ModelUser()
    var msgFetched : ModelMessage = ModelMessage()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.msgFetched.MessageSortedByTarget(withTarget: Session.sharedInstance.getStatus()!, withLogin: Session.sharedInstance.getLogin()!).delegate = self
        self.msgFetched.refreshMsg()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        messagesTable.tableHeaderView = searchController.searchBar
        
        groupPicked = pickerData[groupPicker.selectedRow(inComponent: 0)]
        
        // Do any additional setup after loading the view.
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
        groupPicked = pickerData[groupPicker.selectedRow(inComponent: 0)]
        return groupPicked
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.performSegue(withIdentifier: "deconnect", sender: self)
        let usersDisc = userFetched.getUsersByLogin(withLogin: Session.sharedInstance.getLogin()!)
        usersDisc[0].isConnected = false
        Session.sharedInstance.endSession()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (searchController.isActive && searchController.searchBar.text != "") {
            return self.filteredMessages.count
        } else {
            return self.msgFetched.getNumberMessages()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        var user = userFetched.getUsersByLogin(withLogin: Session.sharedInstance.getLogin()!)
        
        let message: Message
        
        if(searchController.isActive && searchController.searchBar.text != "") {
            message = filteredMessages[indexPath.row]
        }
        else {
            message = self.msgFetched.getMessages().object(at: indexPath)
        }
        
        cell.dateLabel.text = message.date
        cell.loginLabel.text = message.sender
        cell.targetLabel.text = message.target
        
        /*if(user.isEmpty){
            cell.isConnectedImage.isHidden = true
            cell.isNotConnectedImage.isHidden = true
        } else {
            if(user[0].isConnected == true){
                cell.isConnectedImage.isHidden = false
                cell.isNotConnectedImage.isHidden = true
            } else {
                cell.isConnectedImage.isHidden = true
                cell.isNotConnectedImage.isHidden = false
            }
        }*/
        
        if message.img != nil{
            cell.imgMessage.image = UIImage(data: message.img as! Data)
            cell.messageLabel.text = ""
        } else {
            cell.imgMessage.image = nil
            cell.messageLabel.text = message.text
        }
        
        if user[0].photo != nil {
            var thesender = userFetched.getUsersByLogin(withLogin: message.sender!)
            if(thesender.isEmpty){
                cell.userPicture.image = UIImage(named: "user")
            } else {
                cell.userPicture.image = UIImage(data: thesender[0].photo as! Data)
            }
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
        let group = self.groupPicked
        
        if(messageText != "")
        {
            msgFetched.sendMessage(withMessage: messageText!, withTarget: groupPicked!)
            
            
        } else {
            self.AlertEmpty()
        }
        self.viewDidLoad()
        
    }
    
    //search functions
    func filterContentForSearchText(searchText: String) {
        
        let listMessages = msgFetched.getMessageByTarget(withTarget: Session.sharedInstance.getStatus()!)
        
        var message: [String] = []
        for i in 0...listMessages.count-1 {
            message.append(listMessages[i].text!)
        }
        
        var login: [String] = []
        for i in 0...listMessages.count-1 {
            login.append(listMessages[i].sender!)
        }
        
        var targets: [String] = []
        for i in 0...listMessages.count-1 {
            targets.append(listMessages[i].sender!)
        }
        
        filteredMessages = listMessages.filter { message in
            return (message.text?.lowercased().contains(searchText.lowercased()))!
        } + listMessages.filter { login in
                return (login.sender?.lowercased().contains(searchText.lowercased()))!
        } + listMessages.filter { targets in
            return (targets.target?.lowercased().contains(searchText.lowercased()))!
        }
        messagesTable.reloadData()
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
