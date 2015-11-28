//
//  ViewController.swift
//  swift-core-data-architecture
//
//  Created by Matthias Holdorf on 20/11/15.
//  Copyright © 2015 Matthias Holdorf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = BLLContext.userService.createUser()
        person.age = 25
        person.firstName = "Matthias"
        person.lastName = "Holdorf"
        print(person)
        
        let person1 = BLLContext.userService.createUser()
        person1.age = 28
        person1.firstName = "G"
        person1.lastName = "Nasir"
        
        let usersSortedByFirstName = BLLContext.userService.getAllUsersSortedByFirstName();
        print("Users sorted by first name: ", usersSortedByFirstName.description)

        let usersSortedByLastName = BLLContext.userService.getAllUsersSortedByLastName();
        print("Users sorted by last name: ", usersSortedByLastName.description)

        
    }
}