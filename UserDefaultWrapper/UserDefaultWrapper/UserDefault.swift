//
//  UserDefault.swift
//  UserDefaultWrapper
//
//  Created by Dulio Denis on 6/24/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            // TODO
            return defaultValue
        }
        set {
            // TODO
        }
    }
}
