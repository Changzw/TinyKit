//
//  Model_Specialize.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

struct PeopleInfo {
  var name: String
  var age: Int
}

extension PeopleInfo {
  static var key: AnyHashable {
    "key"
  }
  
  init?(notification: Notification) {
    guard let p = notification.userInfo?[Self.key] as? Self else {
      return nil
    }
    self = p
  }
}

extension PeopleInfo {
  static var notificationNameA: Notification.Name {
    .init("A")
  }
  static var notificationNameB: Notification.Name {
    .init("A")
  }
}

extension NotificationCenter {
  // 發送通知用的便利方法
  func post(peopleInfo: PeopleInfo, object: Any? = nil) {
    post(name: PeopleInfo.notificationNameA, object: object, userInfo: [PeopleInfo.key : peopleInfo])
  }
}
