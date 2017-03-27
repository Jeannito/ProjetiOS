//
//  ModelLink.swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 27/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ModelLink {
    
    //CoreData
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Link> = Link.fetchRequest()
    
    //create var NSFetchedResultsController
    fileprivate lazy var linkFetched : NSFetchedResultsController<Link> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Link.name),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    //initilization of class
    init(){
        do {
            try linkFetched.performFetch()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    //function refreshing/performing link fetched
    func refreshLink(){
        do {
            try linkFetched.performFetch()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    //get a link in tab by name
    func getLinksByName(withName: String) -> [Link] {
        var links: [Link] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Link> = Link.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", withName)
        do {
            try links = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return links
    }
    
    //function sending all link of database in a tab
    func getAllLinks() -> [Link] {
        var links: [Link] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Link> = Link.fetchRequest()
        do {
            try links = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return links
    }
    
    //getter of class returning all link
    func getLink() -> NSFetchedResultsController<Link>  {
        return linkFetched
    }
    
    //delete link with the link in parameter
    func deletelink(withLink: Link){
        CoreDataManager.context.delete(withLink)
        CoreDataManager.save()
    }
    
    //function sending the number of link in the database
    func getNumberLink() -> Int {
        return (linkFetched.fetchedObjects!.count)
    }
    
    
}
