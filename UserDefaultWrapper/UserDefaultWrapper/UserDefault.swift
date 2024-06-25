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
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

// extensions to the property wrapper to support arrays and dictionaries
extension UserDefault where T: ExpressibleByArrayLiteral {
    var wrappedValue: T {
        get {
            return UserDefaults.standard.array(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension UserDefault where T: ExpressibleByDictionaryLiteral {
    var wrappedValue: T {
        get {
            return UserDefaults.standard.dictionary(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
