//
//  EventTableViewController.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 26/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class EventTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate  {
    
    @IBOutlet weak var eventTable: UITableView!
    
    var eventFetch : ModelEvent = ModelEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventFetch.getEvent().delegate = self
        self.eventFetch.refreshEvent()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventFetch.getNumberEvent()
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.eventTable.beginUpdates()
        if((Session.sharedInstance.getStatus() == "Manager") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            self.eventFetch.deleteEvent(withEvent: self.eventFetch.getEvent().object(at: indexPath))
        }
        self.eventTable.endUpdates()
    }
    
    func AddHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let addEvent : EventHelper = EventHelper()
        let eventAdd = self.eventFetch.getEvent().object(at: indexPath)
        addEvent.generateEvent(withEvent: eventAdd)
        
        AlertManager.alert(view: self, WithTitle: "Event added", andMsg: "This event is added to your calendar")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    if((Session.sharedInstance.getStatus() == "Manager") || (Session.sharedInstance.getStatus() == "Administration") || (Session.sharedInstance.getStatus() == "Teacher")){
            let delete = UITableViewRowAction(style:.default, title: "Delete", handler: self.deleteHandlerAction)
            delete.backgroundColor = UIColor.red
            let add = UITableViewRowAction(style:.default, title: "Add Calendar", handler: self.AddHandlerAction)
            add.backgroundColor = UIColor.blue
            return [delete, add]
        }
        else {
            let add = UITableViewRowAction(style:.default, title: "Add Calendar", handler: self.AddHandlerAction)
            add.backgroundColor = UIColor.blue
            return [add]
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventViewCell
        
        let event = self.eventFetch.getEvent().object(at: indexPath)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy EEE - hh:mm:ss a"
        let resultDateDebut = formatter.string(from: event.dateDebut as! Date)
        let resultDateFin = formatter.string(from: event.dateFin as! Date)
        let resultStringDateDebut = String(resultDateDebut)
        let resultStringDateFin = String(resultDateFin)
        
        cell.titreEventLabel.text = event.titre
        cell.dateFinEvent.text = resultStringDateDebut
        cell.dateDebutEvent.text = resultStringDateFin
        cell.noteEventLabel.text = event.note
        
        return cell
    }
    
    // MARK: - NSFetchResultController delegate protocol
    /// Start the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventTable.beginUpdates()
    }
    
    /// End the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventTable.endUpdates()
        self.eventTable.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath{
                self.eventTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.eventTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
}
