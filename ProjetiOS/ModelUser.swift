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
    
    //CoreData
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<User> = User.fetchRequest()
    
    //create var NSFetchedResultsController
    fileprivate lazy var userFetched : NSFetchedResultsController<User> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(User.login),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    //initilization of class
    init(){
        do {
            try userFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get user\(error)")
        }
    }

    //function refreshing/performing users fetched
    func refreshUser(){
        do {
            try userFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get users\(error)")
        }
        
    }
    
    //getter of class returning all users
    func getUser() -> NSFetchedResultsController<User>  {
        return userFetched
    }
    

    //get a user in tab by login
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
    
    //function sending all users of database
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
    
    //delete event with the login of user in parameter
    func deleteUserByLogin(withLogin: String){
        let user = getUsersByLogin(withLogin: withLogin)
        CoreDataManager.context.delete(user[0])
    }
    
    //delete event with the user in parameter
    func deleteUser(withUser: User){
        CoreDataManager.context.delete(withUser)
        CoreDataManager.save()
    }
    
    func getNumberUser() -> Int {
        return (userFetched.fetchedObjects!.count)
    }

    
}
