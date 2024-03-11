//
//  Person.swift
//  Project10
//
//  Created by Ruslan Dorosh on 25.10.2022.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeConditionalObject(name, forKey: "name")
        aCoder.encodeConditionalObject(image, forKey: "image")
    }
}
