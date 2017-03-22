//
//  membersListViewController.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 22/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData

class membersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var usersTable: UITableView!
    
    var users = User.getAllUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.usersTable.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        
        
        cell.lastNameLabel.text = self.users[indexPath.row].nom
        cell.firstNameLabel.text = self.users[indexPath.row].prenom
        cell.statusLabel.text = self.users[indexPath.row].status
        
        return cell
    }
}

