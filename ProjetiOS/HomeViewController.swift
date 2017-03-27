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
    
    //Outlet declaration
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var MessageField: UITextField!
    
    //picker result variable and data
    var groupPicked: String?
    let pickerData = ["All", "Student","Teacher","Manager", "Administration"]
    
    //variables - user and message info retrieved from model
    var userFetched : ModelUser = ModelUser()
    var msgFetched : ModelMessage = ModelMessage()
    
    //search bar controller declaration
    let searchController = UISearchController(searchResultsController: nil)
    
    //variable declaration for storing the search results
    var filteredMessages = [Message]()
    
    //load information
    override func viewDidLoad() {
        super.viewDidLoad()
        self.msgFetched.MessageSortedByTarget(withTarget: Session.sharedInstance.getStatus()!, withLogin: Session.sharedInstance.getLogin()!).delegate = self
        self.msgFetched.refreshMsg()
        
        //search bar settings
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        messagesTable.tableHeaderView = searchController.searchBar
        
        //default value for picker
        groupPicked = pickerData[groupPicker.selectedRow(inComponent: 0)]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if search bar is active
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
        
        //load info in cell
        cell.dateLabel.text = message.date
        cell.loginLabel.text = message.sender
        cell.targetLabel.text = message.target
        
        //check image
        if message.img != nil{
            cell.imgMessage.image = UIImage(data: message.img as! Data)
            cell.messageLabel.text = ""
        } else {
            cell.imgMessage.image = nil
            cell.messageLabel.text = message.text
        }
        
        //checkphoto
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
        
        //functionnality not working
        /*if(user.isEmpty){
            cell.isConnectedImage.isHidden = true
            cell.isNotConnectedImage.isHidden = true
        } else {
            if(user[0].isConnected == true){
                cell.isConnectedImage.isHidden = false
                cell.isNotConnectedImage.isHidden = true
            } else if(user[0].isConnected == false){
                cell.isConnectedImage.isHidden = true
                cell.isNotConnectedImage.isHidden = false
            } else {
                cell.isConnectedImage.isHidden = true
                cell.isNotConnectedImage.isHidden = true
            }
        }*/
        
        return cell
    }
    
    //update page functions
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messagesTable.beginUpdates()
    }
    
    
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
    
    //Action - sign out
    @IBAction func signOut(_ sender: Any) {
        self.performSegue(withIdentifier: "deconnect", sender: self)
        let usersDisc = userFetched.getUsersByLogin(withLogin: Session.sharedInstance.getLogin()!)
        usersDisc[0].isConnected = false
        Session.sharedInstance.endSession()
    }
    
    //Action - send message
    @IBAction func sendAction(_ sender: Any) {
        let messageText = self.MessageField.text
        let group = self.groupPicked
        
        if ((MessageField.text?.isEmpty)!) {
            AlertManager.alert(view: self, WithTitle: "Error !", andMsg: "Empty message !")
            return
        }
        
        msgFetched.sendMessage(withMessage: messageText!, withTarget: groupPicked!)
        
        self.viewDidLoad()
        
    }
    
}
//extension for search bar fonctionnaality
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
