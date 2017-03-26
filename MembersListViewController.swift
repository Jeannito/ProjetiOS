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
    
    var user : ModelUser = ModelUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user.getUser().delegate = self
        self.user.refreshUser()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.user.getNumberUser()
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersTable.beginUpdates()
        if((Session.sharedInstance.getStatus() == "Responsible") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            self.user.deleteUser(withUser: self.user.getUser().object(at: indexPath))
        }
        self.usersTable.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if((Session.sharedInstance.getStatus() == "Responsible") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            let delete = UITableViewRowAction(style:.default, title: "Delete", handler: self.deleteHandlerAction)
            delete.backgroundColor = UIColor.red
            return [delete]
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.usersTable.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UserTableViewCell
        
        let users = self.user.getUser().object(at: indexPath)
        
        cell.lastNameLabel.text = users.nom
        cell.firstNameLabel.text = users.prenom
        cell.statusLabel.text = users.status
        cell.loginLabel.text = users.login
        cell.emailLabel.text = users.email
        cell.promotionLabel.text = users.promotion
        cell.yearLabel.text = users.annee
        if users.photo != nil {
            cell.userPicture.image = UIImage(data: users.photo as! Data)
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
        self.usersTable.beginUpdates()
    }
    
    /// End the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
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
    
}
