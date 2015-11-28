//
//  Service.swift
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import Foundation

class Service {
    static let sharedDalContext = DALContext()
    
    /*
    Saves all the pending changes to the underlying database and returns the status
    
    :params: void
    
    :returns: status of saving changes
    */
    func saveChanges() {
        Service.sharedDalContext.databaseContext.saveContext()
    }
}