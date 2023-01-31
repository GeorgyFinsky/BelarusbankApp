//
//  RealmManager.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import Foundation

class RealmManager<T> where T: Object {
    private let realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
    
}
