//
//  ModelPicture.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ModelPicture {
    
    //CoreData
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Image> = Image.fetchRequest()
    
    //create var NSFetchedResultsController
    fileprivate lazy var imageFetched : NSFetchedResultsController<Image> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Image.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    //initilization of class
    init(){
        do {
            try imageFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get image\(error)")
        }
    }
    
    //function refreshing/performing events fetched
    func refreshImage(){
        do {
            try imageFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get images\(error)")
        }
        
    }
    
    //getter of class returning all event
    func getImage() -> NSFetchedResultsController<Image>  {
        return imageFetched
    }
    
    //function sending the number of event in the database
    func getNumberImage() -> Int {
        return (imageFetched.fetchedObjects!.count)
    }
    
    
}
