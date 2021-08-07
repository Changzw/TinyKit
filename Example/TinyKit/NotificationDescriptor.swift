//
//  NotificationDescriptor.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

struct NotificationDescriptor<A> {
  let name: Notification.Name
  let convert: (Notification) -> A
}

extension NotificationCenter {
  func addObserver<A>(forDescriptor d: NotificationDescriptor<A>, using block: @escaping (A) -> ()) -> NSObjectProtocol {
    return addObserver(forName: d.name, object: nil, queue: nil, using: { note in
      block(d.convert(note))
    })
  }
}

struct PlaygroundPayload {
  let page: Any?
  let needsIndefiniteExecution: Bool
}

extension PlaygroundPayload {
  init(note: Notification) {
    page = note.object
    needsIndefiniteExecution = note.userInfo!["PlaygroundPageNeedsIndefiniteExecution"] as! Bool
  }
}
