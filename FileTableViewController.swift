//
//  FileTableViewController.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 27/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData


class FileTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate  {

    @IBOutlet weak var fileTable: UITableView!

    var linkFetched : ModelLink = ModelLink()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredLink = [Link]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.linkFetched.getLink().delegate = self
        self.linkFetched.refreshLink()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        fileTable.tableHeaderView = searchController.searchBar
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive && searchController.searchBar.text != "") {
            return self.filteredLink.count
        }
        return self.linkFetched.getNumberLink()
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.fileTable.beginUpdates()
        if((Session.sharedInstance.getStatus() == "Manager") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            self.linkFetched.deletelink(withLink: self.linkFetched.getLink().object(at: indexPath))
        }
        self.fileTable.endUpdates()
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
        
        let cell = self.fileTable.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath) as! FileViewCell
        
        let link: Link
        
        if(searchController.isActive && searchController.searchBar.text != "") {
            link = filteredLink[indexPath.row]
        }
        else {
            link = self.linkFetched.getLink().object(at: indexPath)
        }
        
        cell.nameFileLabel.text = link.name
        cell.linkLabel.text = link.link
        
        return cell
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.fileTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.fileTable.endUpdates()
        self.fileTable.reloadData()
    }
    
    //search functions
    func filterContentForSearchText(searchText: String) {
        let listLink = linkFetched.getAllLinks()
        
        var noms: [String] = []
        for i in 0...listLink.count-1 {
            noms.append(listLink[i].name!)
        }
        
        var linksWanted: [String] = []
        for i in 0...listLink.count-1 {
            linksWanted.append(listLink[i].link!)
        }
        
        filteredLink = listLink.filter { noms in
            return (noms.name?.lowercased().contains(searchText.lowercased()))!
            }  + listLink.filter { linksWanted in
                return (linksWanted.link?.lowercased().contains(searchText.lowercased()))!
        }
        
        fileTable.reloadData()
    }
}

extension FileTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


