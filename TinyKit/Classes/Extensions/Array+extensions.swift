//
//  Array+extensions.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/7/19.
//

import Foundation

public extension Array {
  func safeObject(at index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }

  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
}
