//
//  ModelMessage.swift
//  ProjetiOS
//
//  Created by Jean BRUTE-DE-REMUR on 22/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit

import Foundation
import CoreData
import UIKit

class ModelMessage{
    
    // MARK: - CoreData Constant
    
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Message> = Message.fetchRequest()
    
    // MARK: - Variables
    
    fileprivate lazy var msgFetched : NSFetchedResultsController<Message> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.date),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController}()
    
    // MARK : - Initialization
    
    /// Initialize the messages by fetching all msg in the DB
    init(){
        do {
            try msgFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get messages\(error)")
        }
    }
    
    // MARK: - Help methods
    
    /// Re-perform the fetch for the NSFetchResult
    func refreshMsg(){
        do {
            try msgFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get messages\(error)")
        }
        
    }
    
    // MARK: - Getters
    
    /// Get all the messages
    ///
    /// - Returns: msgFetched
    func getMessages() -> NSFetchedResultsController<Message>  {
        return msgFetched
    }
    
    /// Get the number of msg in the DB
    ///
    /// - Returns: number of msg (int)
    func getNumberMessages() -> Int {
        return (msgFetched.fetchedObjects!.count)
    }
    
    func getMessageByStatus(withStatus: String) -> [Message] {
        var messages: [Message] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "status == %@", withStatus)
        do {
            try messages = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get message by status=\(withStatus): \(error)")
        }
        return messages
    }
    
    func getMessageByLogin(withLogin: String) -> [Message] {
        var messages: [Message] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", withLogin)
        do {
            try messages = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get message by status=\(withLogin): \(error)")
        }
        return messages
    }
    
    func getAllMessage() -> [Message] {
        var messages: [Message] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        do {
            try messages = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return messages
    }
    
    func sendMessage(withMessage: String, withTarget: String){
        let context = CoreDataManager.getContext()
        
        let message = Message(context: context)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        let result = formatter.string(from: date)
        let resultString = String(result)
        let instance = Session.sharedInstance
        
        message.date = resultString
        message.status = instance.getStatus()
        message.sender = instance.getLogin()
        message.text = withMessage
        message.target = withTarget
        
        CoreDataManager.save()
    }
}
