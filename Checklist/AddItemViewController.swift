//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/14/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidChange(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0)
       
        return true
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidChange(self)
    }
    
    @IBAction func done() {
        
        //var checklistViewController: ChecklistViewController
        
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        
        delegate?.addItemViewController(self, didFinishAdding: item)
        
        //checklistViewController.add(item)
        
        print("Contents of the text field: \(textField.text!)")
        
        dismiss(animated: true, completion: nil)
    }
    

}

