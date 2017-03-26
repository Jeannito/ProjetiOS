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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.eventTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventViewCell
        
        let event = self.eventFetch.getEvent().object(at: indexPath)
        
        cell.titreEventLabel.text = event.titre
        cell.dateFinEvent.text = "02/03/09"
        cell.dateDebutEvent.text = "02/04/09"
        cell.noteEventLabel.text = event.note
        
        cell.addCalendarButton.tag = indexPath.row
        cell.addCalendarButton.addTarget(self, action: #selector(addEventCalendar(sender:)), for: .touchUpInside)
        return cell
    }
    
    func addEventCalendar(sender: AnyObject /*withTitle: String, withNote: String, withDateDebut: Date, withDateFin: Date*/){
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = "Test Title"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{
                
                print("failed to save event with error : \(error) or access not granted")
            }
        }
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
