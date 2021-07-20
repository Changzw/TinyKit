//
//  UserDefaultsStorage.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/4/1.
//  Copyright © 2021 常仲伟. All rights reserved.
//

import Foundation

// swift 5.1+, like @AppStorage in SwiftUI
public struct UserDefaultsKey: RawRepresentable {
  public let rawValue: String
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}
extension UserDefaultsKey: Hashable&Equatable {}

private protocol AnyOptional {
  var isNil: Bool { get }
}
extension Optional: AnyOptional {
  var isNil: Bool { self == nil }
}

@propertyWrapper
public struct UserDefaultsStorage<Value> {
  private let key: UserDefaultsKey
  private let defaultValue: Value
  public var storage: UserDefaults = .standard
  
  public var wrappedValue: Value {
    get {
      let value = storage.object(forKey: key.rawValue) as? Value
      return value ?? defaultValue
    }
    set {
      if let op = newValue as? AnyOptional, op.isNil {
        storage.removeObject(forKey: key.rawValue)
      } else {
        storage.set(newValue, forKey: key.rawValue)
      }
    }
  }
  
  public init(
    wrappedValue defaultValue: Value,
    key: UserDefaultsKey,
    storage: UserDefaults = .standard
  ) {
    self.defaultValue = defaultValue
    self.key = key
    self.storage = storage
  }
}

extension UserDefaultsStorage where Value: Codable { }
extension UserDefaultsStorage where Value: ExpressibleByNilLiteral {
  public init(key: UserDefaultsKey, storage: UserDefaults = .standard) {
    self.init(wrappedValue: nil, key: key, storage: storage)
  }
}
