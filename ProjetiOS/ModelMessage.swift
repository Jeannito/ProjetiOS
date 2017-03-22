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

extension Message {
    
    class func getMessageByStatus(withStatus: String) -> [Message] {
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
    
    class func getAllMessage() -> [Message] {
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
    
    class func sendMessage(withMessage: String){
        let context = CoreDataManager.getContext()
        
        let message = Message(context: context)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        let resultString = String(result)
        let instance = Session.sharedInstance
        
        message.date = resultString
        message.idM = 1
        message.status = instance.getStatus()
        message.sender = instance.getLogin()
        message.text = withMessage
    }
}
