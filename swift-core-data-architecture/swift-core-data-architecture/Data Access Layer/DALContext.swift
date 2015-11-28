//
//  DALContext.swift
//  swift-core-data-architecture
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import Foundation
import CoreData

class DALContext {
    internal var databaseContext: DatabaseContext
    internal var userRepository: Repository<User>

    /*
    Initializes the Database context and all the related repositories (such as user, location etc.) and uses shared database for all the repositories
    
    :params: none
    
    :returns: (implicit) object of type DALContext
    */
    init() {
        databaseContext = DatabaseContext()
        
        userRepository = Repository<User>(databaseContext: self.databaseContext)
    }
}