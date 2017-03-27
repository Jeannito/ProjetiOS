//
//  MembersListViewController.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//
import UIKit
import CoreData

class MembersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate  {
    
    @IBOutlet weak var usersTable: UITableView!
    
    var userFetched : ModelUser = ModelUser()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userFetched.getUser().delegate = self
        self.userFetched.refreshUser()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        usersTable.tableHeaderView = searchController.searchBar
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive && searchController.searchBar.text != "") {
            return self.filteredUsers.count
        }
        return self.userFetched.getNumberUser()
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersTable.beginUpdates()
        if((Session.sharedInstance.getStatus() == "Manager") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            self.userFetched.deleteUser(withUser: self.userFetched.getUser().object(at: indexPath))
        }
        self.usersTable.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if((Session.sharedInstance.getStatus() == "Manager") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            let delete = UITableViewRowAction(style:.default, title: "Delete", handler: self.deleteHandlerAction)
            delete.backgroundColor = UIColor.red
            return [delete]
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.usersTable.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UserTableViewCell
        
        let user: User
        
        if(searchController.isActive && searchController.searchBar.text != "") {
            user = filteredUsers[indexPath.row]
        }
        else {
            user = self.userFetched.getUser().object(at: indexPath)
        }
        
        cell.lastNameLabel.text = user.nom
        cell.firstNameLabel.text = user.prenom
        cell.statusLabel.text = user.status
        cell.loginLabel.text = user.login
        cell.emailLabel.text = user.email
        cell.promotionLabel.text = user.promotion
        cell.yearLabel.text = user.annee
        
        if(user.isConnected == true){
            cell.isConnectedImage.isHidden = false
            cell.isNotConnectedImage.isHidden = true
        } else {
            cell.isConnectedImage.isHidden = true
            cell.isNotConnectedImage.isHidden = false
        }
        
        if user.photo != nil {
            cell.userPicture.image = UIImage(data: user.photo as! Data)
        } else {
            cell.userPicture.image = UIImage(named: "user")
        }
        
        return cell
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.usersTable.beginUpdates()
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.usersTable.endUpdates()
        self.usersTable.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath{
                self.usersTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.usersTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    //search functions
    func filterContentForSearchText(searchText: String) {
        let listUsers = userFetched.getAllUsers()
        
        var noms: [String] = []
        for i in 0...listUsers.count-1 {
            noms.append(listUsers[i].nom!)
        }
        
        var prenoms: [String] = []
        for i in 0...listUsers.count-1 {
            prenoms.append(listUsers[i].prenom!)
        }
        
        var promotions: [String] = []
        for i in 0...listUsers.count-1 {
            promotions.append(listUsers[i].promotion!)
        }
        
        var years: [String] = []
        for i in 0...listUsers.count-1 {
            years.append(listUsers[i].annee!)
        }
        
        var statuses: [String] = []
        for i in 0...listUsers.count-1 {
            statuses.append(listUsers[i].status!)
        }
        
        filteredUsers = listUsers.filter { noms in
            return (noms.nom?.lowercased().contains(searchText.lowercased()))!
        } + listUsers.filter { prenoms in
            return (prenoms.prenom?.lowercased().contains(searchText.lowercased()))!
        } + listUsers.filter { promotions in
                return (promotions.promotion?.lowercased().contains(searchText.lowercased()))!
        } + listUsers.filter { years in
                return (years.annee?.lowercased().contains(searchText.lowercased()))!
        } + listUsers.filter { statuses in
                return (statuses.status?.lowercased().contains(searchText.lowercased()))!
        }
        
        usersTable.reloadData()
    }
}

extension MembersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
