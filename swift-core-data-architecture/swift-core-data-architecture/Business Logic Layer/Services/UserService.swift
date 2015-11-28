//
//  UserService.swift
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import Foundation

class UserService: Service {
    /*
    Creates (in database) and returns the User entity
    
    :params: none
    
    :returns: object of type User
    */
    func createUser() -> User {
        return Service.sharedDalContext.userRepository.createEntity()
    }
    
    /*
    Returns the list of all the Users
    
    :params: none
    
    :returns: Array of all the Users
    */
    func getAllUsers() -> Array<User> {
        return Service.sharedDalContext.userRepository.getAllEntities()
    }
    
    /*
    Returns the list of all the Users sorted by first name
    
    :params: none
    
    :returns: Array of all the Users sorted by first name
    */
    func getAllUsersSortedByFirstName() -> Array<User> {
        let byFirstNameSortDescriptor = NSSortDescriptor.init(key: "firstName", ascending: true)
        
        return Service.sharedDalContext.userRepository.getEntities(sortedBy: byFirstNameSortDescriptor, matchingPredicate: nil)
    }
    
    /*
    Returns the list of all the Users sorted by last name
    
    :params: none
    
    :returns: Array of all the Users sorted by last name
    */
    func getAllUsersSortedByLastName() -> Array<User> {
        let byFirstNameSortDescriptor = NSSortDescriptor.init(key: "lastName", ascending: true)
        
        return Service.sharedDalContext.userRepository.getEntities(sortedBy: byFirstNameSortDescriptor, matchingPredicate: nil)
    }
    
    /*
    Delete the user from the database
    
    :params: the desired User to delete
    
    :returns: none
    */
    func deleteUser(user: User) {
        Service.sharedDalContext.userRepository.deleteEntity(user)
    }
}
