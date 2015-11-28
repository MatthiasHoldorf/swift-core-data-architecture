//
//  User.swift
//  swift-core-data-architecture
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    @NSManaged var lastName: String?
    @NSManaged var firstName: String?
    @NSManaged var age: NSNumber?
}