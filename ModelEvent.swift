//
//  ModelEvent.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 26/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ModelEvent {
    
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Event> = Event.fetchRequest()
    
    fileprivate lazy var eventFetched : NSFetchedResultsController<Event> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Event.titre),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    
    init(){
        do {
            try eventFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get event\(error)")
        }
    }
    
    func refreshEvent(){
        do {
            try eventFetched.performFetch()
        }
        catch let error as NSError{
            fatalError("failed to get event\(error)")
        }
        
    }
    
    
    func getEvent() -> NSFetchedResultsController<Event>  {
        return eventFetched
    }
    
    
    
    func getEventByTitle(withTitle: String) -> [Event] {
        var event: [Event] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "titre == %@", withTitle)
        do {
            try event = context.fetch(request)
        } catch let error as NSError {
            fatalError("failed to get event by login=\(withTitle): \(error)")
        }
        return event
    }
    
    func getAllEvent() -> [Event] {
        var event: [Event] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        do {
            try event = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return event
    }
    
    func deleteEvent(withTitle: String){
        let event = getEventByTitle(withTitle: withTitle)
        CoreDataManager.context.delete(event[0])
    }
    
    func getNumberEvent() -> Int {
        return (eventFetched.fetchedObjects!.count)
    }
    
    func sendEvent(withTitle: String, withNote: String, withDateDebut: Date, withDateFin: Date){
        let context = CoreDataManager.getContext()
        
        let event = Event(context: context)
        
        event.titre = withTitle
        event.note = withNote
        event.dateDebut = withDateDebut as NSDate?
        event.dateFin = withDateFin as NSDate?
        
        CoreDataManager.save()
    }
}
