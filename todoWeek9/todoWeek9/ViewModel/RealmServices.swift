//
//  RealmServices.swift
//  todoWeek9
//
//  Created by Decagon on 5/25/21.
//
import RealmSwift
import Foundation

class RealmService {
    
    static let shared = RealmService()
    // swiftlint:disable:next force_try
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func updateTask(task newTask: String, category: TodoListItem ) {
        do {
            try realm.write {
                category.item = newTask
                realm.add(category)
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
                // swiftlint:disable:next force_try
                try! realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
}
