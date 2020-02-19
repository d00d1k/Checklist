//
//  DataModel.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/17/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import Foundation

class DataModel {
    
    class func nextCheckilstItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    var lists = [Checklist]()
    
    var indexOfSelectChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue,forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirst()
        
        print("docDir\(documentDirectory())")
    }
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(lists, forKey: "Checklists")
        
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            
            unarchiver.finishDecoding()
            
            sortChecklists()
        }
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["ChecklistIndex": -1,
                                         "FirstTime": true,
                                         "ChecklistItemID" : 0]
        
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirst() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    func sortChecklists() {
        lists.sort(by: {checklist1, checklist2 in
            return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending})
    }
}
