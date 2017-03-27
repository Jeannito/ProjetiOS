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
    
    //CoreData
    let context = CoreDataManager.getContext()
    let request : NSFetchRequest<Event> = Event.fetchRequest()
    
    //create var NSFetchedResultsController
    fileprivate lazy var eventFetched : NSFetchedResultsController<Event> = {
        self.request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Event.titre),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: self.request, managedObjectContext: CoreDataManager.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
    //initilization of class
    init(){
        do {
            try eventFetched.performFetch()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    //function refreshing/performing events fetched
    func refreshEvent(){
        do {
            try eventFetched.performFetch()
        }
        catch let error as NSError{
            print(error)
        }
        
    }
    
    //getter of class returning all event
    func getEvent() -> NSFetchedResultsController<Event>  {
        return eventFetched
    }
    
    
    //function getting an event by his title
    func getEventByTitle(withTitle: String) -> [Event] {
        var event: [Event] = []
        let context = CoreDataManager.getContext()
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "titre == %@", withTitle)
        do {
            try event = context.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return event
    }
    
    
    //function sending all events of database
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
    
    //delete event with the event in parameter
    func deleteEvent(withEvent: Event){
        CoreDataManager.context.delete(withEvent)
        CoreDataManager.save()
    }
    
    //function sending the number of event in the database
    func getNumberEvent() -> Int {
        return (eventFetched.fetchedObjects!.count)
    }
    
    //function sending an event in the database
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
