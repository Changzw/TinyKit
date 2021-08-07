//
//  TypedNotification.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol TypedNotification {
  associatedtype Sender
  static var name: String { get }
  var sender: Sender? { get }
}

extension TypedNotification {
  static var notificationName: Notification.Name {
    .init(rawValue: name)
  }
}

protocol TypedNotificationCenter {
  func post<N: TypedNotification>(_ notification: N)
  func addObserver<N: TypedNotification>(
    _ forType: N.Type,
    sender: N.Sender?,
    queue: OperationQueue?,
    using block: @escaping (N) -> Void) -> NSObjectProtocol
}

extension NotificationCenter: TypedNotificationCenter {
  private static var modelKey = "modelKey"
  
  func post<N>(_ notification: N) where N : TypedNotification {
    post(name: N.notificationName,
         object: notification.sender,
         userInfo: [Self.modelKey: notification])
  }
  
  func addObserver<N>(_ forType: N.Type, sender: N.Sender? = nil, queue: OperationQueue? = nil, using block: @escaping (N) -> Void) -> NSObjectProtocol where N: TypedNotification {
    return addObserver(forName: N.notificationName, object: sender, queue: queue) { n in
      guard let model = n.userInfo?[Self.modelKey] as? N else {
        fatalError("Could not construct a typed notification: \(N.name) from notification: \(n)")
      }
      block(model)
    }
  }
}

struct SubscriptionsChanged : TypedNotification {
  var sender: Any? = nil
  static var name = "subscriptionsChanged"
  var subscribed: Set<Int> = []
  var unsusbscribed: Set<Int> = []
}
