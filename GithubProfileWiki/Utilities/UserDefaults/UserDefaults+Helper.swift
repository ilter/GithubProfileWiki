//
//  UserDefaults+Helper.swift
//  GithubProfileWiki
//
//  Created by ilter on 11.02.2022.
//

import Foundation

@propertyWrapper struct UserDefaultsHelper<Value> {
    private let key: String
    private let initialValue: Value
    private var defaultsStorage: UserDefaults {
        UserDefaults.standard
    }

    var wrappedValue: Value {
        get {
            let value = defaultsStorage.value(forKey: key) as? Value
            return value ?? initialValue
        }
        set {
            if let newValue = newValue as? AnyOptional, newValue.isNil {
                defaultsStorage.removeObject(forKey: key)
            } else {
                defaultsStorage.set(newValue, forKey: key)
            }
        }
    }

    init(wrappedValue initialValue: Value, key: String) {
        self.initialValue = initialValue
        self.key = key
    }
}

extension UserDefaultsHelper where Value: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(wrappedValue: nil, key: key)
    }
}
