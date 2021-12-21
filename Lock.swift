//
//  Lock.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/12/21.
//

import Foundation

private protocol Lock {
  func lock()
  func unlock()
}

extension Lock {
  func around<T>(_ block: () throws -> T) rethrows -> T {
    lock(); defer { unlock() }
    return try block()
  }
  
  func around(_ block: () throws -> ()) rethrows {
    lock(); defer { unlock() }
    try block()
  }
}

final class UnfairLock: Lock {
  private let lock_: os_unfair_lock_t
  
  init() {
    lock_ = .allocate(capacity: 1)
    lock_.initialize(to: os_unfair_lock())
  }
  
  deinit {
    lock_.deinitialize(count: 1)
    lock_.deallocate()
  }
  
  fileprivate func lock() {
    os_unfair_lock_lock(lock_)
  }
  
  fileprivate func unlock() {
    os_unfair_lock_unlock(lock_)
  }
}

@propertyWrapper
@dynamicMemberLookup
final class Protected<T> {
  private let lock = UnfairLock()
  private var value: T
  var projectedValue: Protected<T> { self }
  
  var wrappedValue: T {
    get { lock.around { value } }
    set { lock.around { value = newValue } }
  }

  init(_ value: T) {
    self.value = value
  }

  init(wrappedValue: T) {
    value = wrappedValue
  }
  
  func read<U>(_ closure: (T) throws -> U) rethrows -> U {
    try lock.around { try closure(self.value) }
  }
  
  @discardableResult
  func write<U>(_ closure: (inout T) throws -> U) rethrows -> U {
    try lock.around { try closure(&self.value) }
  }
  
  subscript<Property>(dynamicMember keyPath: WritableKeyPath<T, Property>) -> Property {
    get { lock.around { value[keyPath: keyPath] } }
    set { lock.around { value[keyPath: keyPath] = newValue } }
  }
  
  subscript<Property>(dynamicMember keyPath: KeyPath<T, Property>) -> Property {
    lock.around { value[keyPath: keyPath] }
  }
}

extension Protected where T: RangeReplaceableCollection {
  func append(_ newElement: T.Element) {
    write { (ward: inout T) in
      ward.append(newElement)
    }
  }
  
  func append<S: Sequence>(contentsOf newElements: S) where S.Element == T.Element {
    write { (ward: inout T) in
      ward.append(contentsOf: newElements)
    }
  }
  
  func append<C: Collection>(contentsOf newElements: C) where C.Element == T.Element {
    write { (ward: inout T) in
      ward.append(contentsOf: newElements)
    }
  }
}

extension Protected where T == Data? {
  func append(_ data: Data) {
    write { (ward: inout T) in
      ward?.append(data)
    }
  }
}
