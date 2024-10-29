//
//  UserDefaults+Ext.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Combine
import Foundation

extension UserDefaults {
  
  @UserDefault(key: "accessToken", defaultValue: nil)
  static var accessToken: String?
  
}

@propertyWrapper
struct UserDefault<Value> {
  
  let key: String
  let defaultValue: Value
  lazy var container: UserDefaults = .standard
  private let publisher = PassthroughSubject<Value, Never>()

  var wrappedValue: Value {
    mutating get {
      container.object(forKey: key) as? Value ?? defaultValue
    }
    set {
      if let optional = newValue as? AnyOptional, optional.isNil {
        container.removeObject(forKey: key)
      } else {
        publisher.send(newValue)
        container.set(newValue, forKey: key)
      }
    }
  }
  
}
