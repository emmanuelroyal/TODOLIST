//
//  ViewController.swift
//  todoWeek9
//
//  Created by Decagon on 5/22/21.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    @IBOutlet var table: UITableView!
    private var data = [TodoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(TodoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        if editingStyle == .delete {
            RealmService.shared.delete(item)
            self.refresh()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        guard let newViewController = storyboard?.instantiateViewController(identifier: "task") as? TaskViewController else { return
        }
        newViewController.item = item
        newViewController.deletionHandler = { [weak self] in
            self?.refresh()
        }
        newViewController.updatecompletionHandler = { [weak self] in
            self?.refresh()
        }
        newViewController.title = "Task"
        newViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func didTapAddButton() {
        guard let newViewController = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController  else {
            return
        }
        newViewController.completionHandler = { [weak self] in
            self?.refresh()
        }
        newViewController.title = "New Task"
        newViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func refresh() {
        data = realm.objects(TodoListItem.self).map({ $0 })
        table.reloadData()
    }
    
}
