//
//  Realm.swift
//  todoWeek9
//
//  Created by Decagon on 5/25/21.
//
import RealmSwift
import Foundation

class TodoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}
