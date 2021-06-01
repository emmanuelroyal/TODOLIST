//
//  EntryViewController.swift
//  todoWeek9
//
//  Created by Decagon on 5/22/21.
//
import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completionHandler: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    func textFieldShouldReturn(_ textField: UITextField ) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date
            let newItem = TodoListItem()
            newItem.date = date
            newItem.item = text
            RealmService.shared.create(newItem)
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            
        }
    }
}
