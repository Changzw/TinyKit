//
//  Int+extension.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

extension Int {
  private var sureTwo: String {
    if self >= 10 {
      return String(self)
    } else {
      return "0\(self)"
    }
  }
  
  private var raw: String {
    String(self)
  }
  
  var hhmmss: String {
    let h = self / 3600
    let other = self % 3600
    let m = other / 60
    let s = other % 60
    
    let hh = h.sureTwo
    let mm = m.sureTwo
    let ss = s.sureTwo
    
    return hh + ":" + mm + ":" + ss
  }
  
  var hhmm: String {
    let h = self / 3600
    let other = self % 3600
    let m = other / 60
    
    let hh = h.sureTwo
    let mm = m.sureTwo
    
    return hh + ":" + mm
  }
  
  var mmss: String {
    let m = self / 60
    let s = self % 60
    
    let mm = m.sureTwo
    let ss = s.sureTwo
    
    return mm + ":" + ss
  }
  
  var mss: String {
    let m = self / 60
    let s = self % 60
    
    let mm = m.raw
    let ss = s.sureTwo
    
    return mm + ":" + ss
  }
  
  var hh: String {
    let h = self / 3600
    let hh = h.sureTwo
    
    return hh
  }
  
  var mm: String {
    let m = self / 60
    let mm = m.sureTwo
    
    return mm
  }
  
  var ss: String {
    let s = self % 60
    let ss = s.sureTwo
    
    return ss
  }
  
  
  /// 把 Int 数字转换成其他格式的字符串数字
  /// - Parameters:
  ///   - multiplier: 乘数因子。如果数字为12345， multiplier 为 0.001，则 12345 * 0.01
  ///   - roundingIncrement: 保留的小数位。如果 roundingIncrement 为 0.01，则代表保留 2 位；如果 roundingIncrement 为 1，则代表不保留小数位
  ///   - suffix: 后缀
  /// - Returns: 其他格式的字符串数字，可能为 nil
  func numberFormatter(with multiplier: NSNumber, roundingIncrement: NSNumber, suffix: String) -> String? {
    let number = Double(self)
    if number * multiplier.doubleValue < 1  {
      return "\(self)"
    }
    let formatter = NumberFormatter();
    formatter.numberStyle = .decimal;
    formatter.multiplier = multiplier
    formatter.allowsFloats = true;
    formatter.positiveSuffix = suffix;
    formatter.roundingIncrement = roundingIncrement;
    formatter.roundingMode = .floor;
    formatter.usesGroupingSeparator = false
    return formatter.string(from: NSNumber(value: number))
  }
  
  func convert(to multiplier: Double, decimalPlaces: Int) -> Double {
    let value = Double(self) * multiplier
    let divisor = pow(10.0, Double(decimalPlaces))
    return (value * divisor).rounded() / divisor
  }
  
}
