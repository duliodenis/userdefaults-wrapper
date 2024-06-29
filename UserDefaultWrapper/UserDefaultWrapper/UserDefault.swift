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
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            Task {
                await UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
    
    var projectedValue: Self {
        self
    }
    
    var hasValue: Bool {
        UserDefaults.standard.object(forKey: key) != nil
    }
    
    func reset() async {
        await UserDefaults.standard.removeObject(forKey: key)
    }
}

// extensions to the property wrapper to support arrays and dictionaries
extension UserDefault where T: ExpressibleByArrayLiteral {
    var wrappedValue: T {
        get {
            UserDefaults.standard.array(forKey: key) as? T ?? defaultValue
        }
        set {
            Task {
                await UserDefaults.standard.set(newValue, forKey: key)
            }
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

// adding support for custom types that conform to Codable
extension UserDefault where T: Codable {
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return defaultValue }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
