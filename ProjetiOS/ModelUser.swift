//
//  ModelUser(bis).swift
//  ProjetiOS
//
//  Created by Bruté de Rémur Raphaël on 23/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//


import Foundation
import CoreData
import UIKit

class ModelUser {
    
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<User> = User.fetchRequest()
    
    fileprivate lazy var userFetched : NSFetchedResultsController<User> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(User.login),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    
    init(){
        do {
            try userFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get user\(error)")
        }
    }

    func refreshUser(){
        do {
            try userFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get users\(error)")
        }
        
    }
    
    
    func getUser() -> NSFetchedResultsController<User>  {
        return userFetched
    }
    


    func getUsersByLogin(withLogin: String) -> [User] {
        var users: [User] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", withLogin)
        do {
            try users = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get user by login=\(withLogin): \(error)")
        }
        return users
    }
    
    func getAllUsers() -> [User] {
        var users: [User] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<User> = User.fetchRequest()
        do {
            try users = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return users
    }
    
    func deleteUser(withLogin: String){
        let user = getUsersByLogin(withLogin: withLogin)
        CoreDataManager.context.delete(user[0])
    }
    
    func getNumberUser() -> Int {
        return (userFetched.fetchedObjects!.count)
    }

    
}
