//
//  Int+extensions.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/7/19.
//

import Foundation

public extension Int {
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
}
