//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/14/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding
{
    func encode(with aDecoder: NSCoder) {
        aDecoder.encode(text, forKey: "Text")
        aDecoder.encode(checked, forKey: "Checked")
        aDecoder.encode(dueDate, forKey: "DueDate")
        aDecoder.encode(shouldRemind, forKey: "ShouldRemind")
        aDecoder.encode(itemID, forKey: "ItemID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "itemID")
        super.init()
    }
    
    override init() {
        checked = false
        itemID = DataModel.nextCheckilstItemID()
        super.init()
    }
    
    func scheduleNotification() {
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let component = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            removeNotification()
            
            print("We should schedule a notofication!")
        }
    }
    
    var text = ""
    var checked: Bool
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked() {
        checked = !checked
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    deinit {
        removeNotification()
    }
}
