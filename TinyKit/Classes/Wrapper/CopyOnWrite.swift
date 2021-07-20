//
//  ValueCopyOnWrite.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/7/19.
//

import Foundation

// https://github.com/apple/swift/blob/main/docs/OptimizationTips.rst#advice-use-copy-on-write-semantics-for-large-values

fileprivate final class Ref<T> {
  var val: T
  init(_ v: T) {val = v}
}

@propertyWrapper
public struct CoW<T> {
  public var wrappedValue: T {
    get { value }
    set { value = newValue }
  }
  
  public init(wrappedValue: T) {
    self.init(wrappedValue)
  }
  
  private var ref: Ref<T>
  init(_ x: T) { ref = Ref(x) }
  
  public var value: T {
    get { return ref.val }
    set {
      if !isKnownUniquelyReferenced(&ref) {
        ref = Ref(newValue)
        return
      }
      ref.val = newValue
    }
  }
}

//MARK: -

extension CoW: Equatable where T: Equatable {}
extension CoW: Hashable where T: Hashable {}

extension Ref: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
  var debugDescription: String { val.debugDescription }
}

extension Ref: Equatable where T: Equatable {
  static func == (lhs: Ref<T>, rhs: Ref<T>) -> Bool {
    lhs.val == rhs.val
  }
}

extension Ref: Hashable where T: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(val)
    let _ = hasher.finalize()
  }
}
