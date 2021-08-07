//
//  Broadcaster.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/31.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol Event: Hashable & Equatable {
  var name: Notification.Name { get }
}

extension Event {
  var infoKey: String {
    "key"
  }
}

struct AnyEvent: Event {
  let name: Notification.Name
  init(name: Notification.Name) {
    self.name = name
  }
  
  static func == (lhs: AnyEvent, rhs: AnyEvent) -> Bool {
    lhs.name == rhs.name
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
//
//protocol Observer: Equatable {
//  associatedtype T
//  var callback: (T)->() { get }
//}

struct AnyObserver<T> {//: Observer {
  let callback: (T) -> ()
  let id: ObjectIdentifier
  init(object: AnyObject, callback: @escaping (T)->()) {
    self.id = ObjectIdentifier(object)
    self.callback = callback
  }
  
//  init<O: Observer>(observer: O) where O.T == T {
//    self.callback = observer.callback
//  }
//  static func == (lhs: AnyObserver, rhs: AnyObserver) -> Bool { lhs == rhs }
}

//class WrappedObserver {
//  let o: AnyObserver<Any>
//  init(observer: AnyObserver<Any>) {
//    o = observer
//  }
//}

//class AnyToken: Token { }
struct BroadcasterToken {
  let token: NSObjectProtocol
  let event: AnyEvent
}

public final class Broadcaster {
//  eventkey: observers
//  static var observersDic: [String: [WrappedObserver]] = [:]
  static let center = NotificationCenter.default
  private static var bag: [ObjectIdentifier: [BroadcasterToken]] = [:]
  
  static func register<T>(observer: AnyObserver<T>, for event: AnyEvent) {
    let t = center.addObserver(forName: event.name, object: nil, queue: .main) { notification in
      guard let info = notification.userInfo?[event.infoKey] as? T else { return }
      observer.callback(info)
    }
    if var tokens = bag[observer.id] {
      tokens.append(BroadcasterToken(token: t, event: event))
    }else {
      bag[observer.id] = [BroadcasterToken(token: t, event: event)]
    }
  }
  
  static func unregister(object: AnyObject, for event: AnyEvent? = nil) {
    guard var binds = bag[ObjectIdentifier(object)], binds.count > 0 else {
      return
    }
    if let e = event {
      if let idx = binds.firstIndex(where: { $0.event == e }) {
        center.removeObserver(binds.remove(at: idx).token, name: event?.name, object: nil)
        bag[ObjectIdentifier(object)] = binds
      }
    }else {
      bag[ObjectIdentifier(object)] = nil
      binds.map(\.token)
        .forEach{
          center.removeObserver($0)
        }
    }
    
//    if let key = event?.name {
//      var old = observersDic[key]
//      old?.removeAll{ $0 == observer }
//      observersDic[key] = old
//    } else {
//      for (key, value) in observersDic {
//        var old = value
//        old.removeAll{ $0 == observer }
//        observersDic[key] = old
//      }
//    }
  }
  
  static func notify<T>(event: AnyEvent, model: T) {
    NotificationCenter.default.post(name: event.name, object: nil, userInfo: [event.infoKey: model])
//    guard let observers = observersDic[event.name] else {return}
//    observers.forEach{
//      $0.callback(model)
//    }
  }
}

