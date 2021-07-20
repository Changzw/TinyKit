//
//  Log.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/7/19.
//

import Foundation

public func address(of object: UnsafeRawPointer) -> String {
  let addr = Int(bitPattern: object)
  return String(format: "%p", addr)
}
