//
//  Checklist.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/16/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding
{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        super.init()
    }
    
    var name = ""
    var items: [ChecklistItem] = []

    init(name: String) {
        self.name = name
        super.init()
    }
}
