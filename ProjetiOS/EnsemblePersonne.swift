//
//  EnsemblePersonne.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 02/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension User {
    

    class func getUsersByLogin(withLogin: String) -> [User] {
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
    
    class func getAllUsers() -> [User] {
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
    
    
}
