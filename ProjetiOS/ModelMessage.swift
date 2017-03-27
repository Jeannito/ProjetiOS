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
    
    //CoreData
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Message> = Message.fetchRequest()
    
    //Create the variable
    fileprivate lazy var msgFetched : NSFetchedResultsController<Message> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.date),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController}()
    
    //Initialize the class
    init(){
        do {
            try msgFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get messages\(error)")
        }
    }
    
    //Refresh/Perform the message fetched
    func refreshMsg(){
        do {
            try msgFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get messages\(error)")
        }
        
    }
    
    //getter of class returning all message
    func getMessages() -> NSFetchedResultsController<Message>  {
        return msgFetched
    }
    
    //function sending the number of message in the database
    func getNumberMessages() -> Int {
        return (msgFetched.fetchedObjects!.count)
    }
    
    //function getting the NSFetchedResultsController with the message sorted by target and Login
    func MessageSortedByTarget(withTarget: String, withLogin: String) -> NSFetchedResultsController<Message> {
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.date),ascending:true)]
        request.predicate = NSPredicate(format: "target == %@ OR target == %@ OR sender == %@", "All", withTarget, withLogin)
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        self.msgFetched = fetchResultController
        return msgFetched
    }
    
    //function sending all events of database
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
    
    //function get messages by target in a tab
    func getMessageByTarget(withTarget: String) -> [Message] {
        var messages: [Message] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "target == %@ OR target == %@","All" ,withTarget)
        do {
            try messages = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get message by target=\(withTarget): \(error)")
        }
        return messages
    }
    
    //function sending a message to the database
    func sendMessage(withMessage: String, withTarget: String){
        let context = CoreDataManager.getContext()
        
        //Get context
        let message = Message(context: context)
        
        //Prepare date for send it to the database
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        let result = formatter.string(from: date)
        let resultString = String(result)
        let instance = Session.sharedInstance
        
        //Save data in the database
        message.date = resultString
        message.status = instance.getStatus()
        message.sender = instance.getLogin()
        message.text = withMessage
        message.target = withTarget
        
        CoreDataManager.save()
    }
}

