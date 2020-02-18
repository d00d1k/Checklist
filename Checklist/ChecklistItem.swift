//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/14/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding
{
    func encode(with aDecoder: NSCoder) {
        aDecoder.encode(text, forKey: "Text")
        aDecoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        checked = false
        super.init()
    }
    
    var text = ""
    var checked: Bool
    
    func toggleChecked() {
        checked = !checked
    }
}
