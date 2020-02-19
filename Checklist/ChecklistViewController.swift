//
//  ChecklistViewController.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/13/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate
{
    func itemDetailViewControllerDidChange(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    var checklist: Checklist!
    var items: [ChecklistItem]
    
    required init? (coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = checklist.items[indexPath.row]
            
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        let item = checklist.items[indexPath.row]
        label.text = item.text
        
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! ItemDetailViewController
            
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! ItemDetailViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "✅"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = "\(item.itemID): \(item.text)"
    }
    
    @IBAction func addItem(){
        let newRowIndex = items.count
        
        let item = ChecklistItem()
        item.text = "I'm a new row"
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }  
}
