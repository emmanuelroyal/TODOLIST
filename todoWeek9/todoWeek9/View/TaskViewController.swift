//
//  TaskViewController.swift
//  todoWeek9
//
//  Created by Decagon on 5/22/21.
//
import RealmSwift
import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {
    public var item: TodoListItem?
    public var deletionHandler: (() -> Void)?
    public var updatecompletionHandler: (() -> Void)?
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet weak var itemTextField: UITextView!
    
    @IBAction func update(_ sender: Any) {
        RealmService.shared.updateTask(task: itemTextField.text!, category: item! )
        updatecompletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item?.item
        dateLabel.text = TaskViewController.dateFormatter.string(from: item!.date)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        RealmService.shared.delete(myItem)
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
