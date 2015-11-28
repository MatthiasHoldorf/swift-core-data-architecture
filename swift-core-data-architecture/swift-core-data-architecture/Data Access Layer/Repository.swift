//
//  Repository.swift
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import Foundation
import CoreData

class Repository<T: NSManagedObject> {
    private let databaseContext : DatabaseContext
    
    // Gets the entity class name
    var entityClassName : String {
        var className = NSStringFromClass(T)
        if className.rangeOfString(".") != nil {
            className = (className as NSString).pathExtension
        }
        return className
    }
    
    init() {
        databaseContext = DatabaseContext()
    }
    
    init(databaseContext: DatabaseContext) {
        self.databaseContext = databaseContext
    }
    
    /*
    Creates and returns the entity. For example, if we create a User Repository, It will create a User entity and return that Entity(Object)
    
    :params: none
    
    :returns: Generic Object T where T is also the type of Repository
    */
    func createEntity() -> T {
        let entity = NSEntityDescription.insertNewObjectForEntityForName(self.entityClassName, inManagedObjectContext: databaseContext.managedObjectContext) as! T
        return entity
    }
    
    /*
    Returns all the objects(records) related to the entity
    
    :params: none
    
    :returns: Array of all the records related to the entity
    */
    func getAllEntities() -> Array<T> {
        return self.getEntities(sortedBy: nil, matchingPredicate: nil)
    }
    
    /*
    Returns all the objects(records) related to the entity (sorted as per the sortDescriptor). An example can be to return all the records sorted by id or creation date
    
    :params: the desired sortDescriptor
    
    :returns: Array of all the records related to the entity (sorted as per the sortDescriptor)
    */
    func getAllEntitiesSortedBy(sortDescriptor:NSSortDescriptor) -> Array<T> {
        return self.getEntities(sortedBy: sortDescriptor, matchingPredicate: nil)
    }
    
    /*
    Returns all the objects(records) matching/filtered w.r.t the given predicate. An example can be to return all the records created today. This is basically used for filtering.
    
    :params: the desired predicate
    
    :returns: Array of all the records related to the entity filtered w.r.t the given predicate
    */
    func getEntitiesMatchingPredicate(predicate: NSPredicate) -> Array<T> {
        return self.getEntities(sortedBy: nil, matchingPredicate: predicate)
    }
    
    /*
    Returns all the objects(records) matching/filtered w.r.t the given predicate and sorted as per the sortDescriptor. An example can be to return all the records created today and sort them by time.
    
    :params: the desired sortDescriptor and predicate
    
    :returns: Array of all the records related to the entity filtered w.r.t the given predicate and sorted as per the sortDescriptor
    */
    func getEntitiesSortedBy(sortDescriptor: NSSortDescriptor, matchingPredicate predicate:NSPredicate) -> Array<T>? {
        return self.getEntities(sortedBy: sortDescriptor, matchingPredicate: predicate)
    }
    
    /*
    Returns all the objects(records) matching/filtered w.r.t the given predicate AND/OR sorted as per the sortDescriptor. The predicate and sortDescriptor are both optional so they can be left out. This is the main methods which is called by the other methods as per their need.
    
    :params: optional sortDescriptor, optional predicate
    
    :returns: Array of all the records related to the entity (May or may not be filtered w.r.t the given predicate and/or sortDescriptor)
    */
    func getEntities(sortedBy sortDescriptor:NSSortDescriptor?, matchingPredicate predicate:NSPredicate?) -> Array<T> {
        // Create the request object
        let request : NSFetchRequest = NSFetchRequest()
        
        // Set the entity type to be fetched
        let entityDescription : NSEntityDescription! = NSEntityDescription.entityForName(self.entityClassName, inManagedObjectContext: databaseContext.managedObjectContext)
        
        request.entity = entityDescription
        
        request.predicate = predicate
        if let sortDescriptor = sortDescriptor {
            request.sortDescriptors = [sortDescriptor] as [NSSortDescriptor]
        }
        
        // Execute the fetch
        do {
            let results = try databaseContext.managedObjectContext.executeFetchRequest(request)
            return results as! [T]
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            return Array<T>()
        }
    }
    
    /*
    Returns N matching/filtered entities w.r.t the given predicate AND/OR sorted as per the sortDescriptor. The predicate and sortDescriptor are both optional so they can be left out. This is the main methods which is called by the other methods as per their need.
    
    :params: optional sortDescriptor, optional predicate, numberOfRecords
    
    :returns: Array of N filtered records related to the entity (May or may not be filtered w.r.t the given predicate and/or sortDescriptor)
    */
    func getFilteredEntities(sortedBy sortDescriptor: NSSortDescriptor?, matchingPredicate predicate: NSPredicate?, numberOfRecords: NSNumber) -> Array<T> {
        let request : NSFetchRequest = NSFetchRequest()
        let entityDescription : NSEntityDescription! = NSEntityDescription.entityForName(self.entityClassName, inManagedObjectContext: databaseContext.managedObjectContext)
        
        request.entity = entityDescription
        request.fetchLimit = numberOfRecords.integerValue
        
        request.predicate = predicate
        if let sortDescriptor = sortDescriptor {
            request.sortDescriptors = [sortDescriptor] as [NSSortDescriptor]
        }
        
        // Execute the fetch
        do {
            let results = try databaseContext.managedObjectContext.executeFetchRequest(request)
            return results as! [T]
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            return Array<T>()
        }
    }
    
    /*
    Deletes the given entity
    
    :params: entity of the given Type
    
    :returns: void
    */
    func deleteEntity(entity: T) {
        databaseContext.managedObjectContext.deleteObject(entity)
        saveEntities()
    }
    
    /*
    Saves all the pending changes to the underlying database
    
    :params: void
    
    :returns: void
    */
    func saveEntities() {
        do {
            try databaseContext.managedObjectContext.save()
        } catch let error as NSError {
            print("Save failed: \(error.localizedDescription)")
        }
    }
}