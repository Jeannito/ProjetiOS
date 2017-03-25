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
    
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Image> = Image.fetchRequest()
    
    fileprivate lazy var imageFetched : NSFetchedResultsController<Image> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Image.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    
    init(){
        do {
            try imageFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get image\(error)")
        }
    }
    
    func refreshImage(){
        do {
            try imageFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get images\(error)")
        }
        
    }
    
    
    func getImage() -> NSFetchedResultsController<Image>  {
        return imageFetched
    }
    
    
    
    func getImageByNom(withName: String) -> [Image] {
        var image: [Image] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Image> = Image.fetchRequest()
        request.predicate = NSPredicate(format: "nom == %@", withName)
        do {
            try image = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get image by nom=\(withName): \(error)")
        }
        return image
    }
    
    func getAllImage() -> [Image] {
        var image: [Image] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Image> = Image.fetchRequest()
        do {
            try image = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return image
    }
    
    func deleteImage(withName: String){
        let image = getImageByNom(withName: withName)
        CoreDataManager.context.delete(image[0])
    }
    
    func getNumberImage() -> Int {
        return (imageFetched.fetchedObjects!.count)
    }
    
    
}
