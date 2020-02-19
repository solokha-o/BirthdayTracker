//
//  Birthday.swift
//  BirthdayTracker
//
//  Created by Oleksandr Solokha on 21.01.20.
//  Copyright © 2020 Oleksandr Solokha. All rights reserved.
//

import Foundation

class Birthday {
    let firstName : String
    let lastName : String
    let birthDate : Date
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}
