//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/14/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}
