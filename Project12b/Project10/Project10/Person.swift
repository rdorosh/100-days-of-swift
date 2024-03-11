//
//  Person.swift
//  Project10
//
//  Created by Ruslan Dorosh on 25.10.2022.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
