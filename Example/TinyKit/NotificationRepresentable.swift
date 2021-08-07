//
//  NotificationRepresentable.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

// 这样设计存在一个问题，就是一种类型只能发送一个 notification 类型
// 解决方案，使用 enum: NotificationRepresentable
// 但是，只要注册过一种类型，那么如果使用 enum 作为结构封装，各种类型都会收到这个通知，然后再据 enum 做区别
protocol NotificationRepresentable { }

extension NotificationRepresentable {
  static var key: AnyHashable {
    String(describing: Self.self)
  }
  
  static var notificationDefaultName: Notification.Name {
    .init(String(reflecting: Self.self))
  }
  
  init?(notification: Notification) {
    guard let value = notification.userInfo?[Self.key] as? Self else { return nil }
    self = value
  }
}

extension NotificationCenter {
  func post<T>(_ notificationRepresentable: T, object: Any? = nil) where T: NotificationRepresentable {
    post(name: T.notificationDefaultName , object: object, userInfo: [T.key : notificationRepresentable])
  }
  
  func addObserver<T>(_ observer: Any, selector: Selector, notificationRepresentableType: T.Type, object: Any? = nil) where T: NotificationRepresentable {
    addObserver(observer, selector: selector, name: notificationRepresentableType.notificationDefaultName, object: object)
  }
}

//MARK: - test
struct AccountInfo {
  let id: Int
  let name: String
}

extension AccountInfo: NotificationRepresentable {}

enum AccountNotificationType {
  case id(Int),
       name(String)
}

extension AccountNotificationType: NotificationRepresentable {}

