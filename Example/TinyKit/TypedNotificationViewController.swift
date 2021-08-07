//
//  TypedNotificationViewController.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import TinyKit

let center = NotificationCenter.default

final class TypedNotificationViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .random
//    broadcaster0()
    let c = NotificationCenter.default
    let t = c.addObserver(forName: Notification.Name("11"), object: nil, queue: nil) {
      print($0)
    }
    c.post(name: Notification.Name("11"), object: nil)
//    c.removeObserver(t)
    c.post(name: Notification.Name("11"), object: nil)
    
  }
  
  deinit {
    print(#function)
    Broadcaster.unregister(object: self, for: nil)
  }
}

// Broadcaster
extension TypedNotificationViewController {
  func broadcaster0() {
    Broadcaster.register(observer: AnyObserver<Int>(object: self, callback: {
      print("22222")
      dump($0)
    }), for: AnyEvent(name: Notification.Name("2333")))

    Broadcaster.register(observer: AnyObserver<Int>(object: self, callback: {
      print("22222")
      dump($0)
    }), for: AnyEvent(name: Notification.Name("2333")))

    Broadcaster.notify(event: AnyEvent(name: Notification.Name("2333")), model: 1001)
  }
}

//TypedNotification
extension TypedNotificationViewController {
  func testTyped0() {
    _ = center.addObserver(SubscriptionsChanged.self, sender: nil, queue: nil) {
      dump($0)
    }
    center.post(SubscriptionsChanged(sender: self, subscribed: [123], unsusbscribed: [567]))
  }
  
  func testTyped1() {
    let playgroundNotification = NotificationDescriptor(name: Notification.Name("111"), convert: PlaygroundPayload.init)
    let token = center.addObserver(forDescriptor: playgroundNotification, using: {
      dump($0)
    })
    
    center.post(name: playgroundNotification.name, object: self, userInfo: ["PlaygroundPageNeedsIndefiniteExecution": true])
  }
}


//NotificationRepresentable
extension TypedNotificationViewController {
  func testRepresentable0() {
    let name = Notification.Name("PlaygroundPageNeedsIndefiniteExecutionDidChangeNotification")
    center.addObserver(forName: name, object: nil, queue: nil, using: { note in
      print("test0")
      dump(note)
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      center.post(name: name, object: nil, userInfo: ["key": 1111])
    }
  }
  
  func testRepresentable1() {
    center.addObserver(self, selector: #selector(didReceive(notification:)), name: Notification.Name("aaaa"), object: nil)
    center.post(name: Notification.Name("aaaa"), object: nil, userInfo: [PeopleInfo.key: PeopleInfo(name: "jjj", age: 11)])
  }
  
  func testRepresentable2() {
    center.addObserver(self, selector: #selector(didReceive(notification:)), name: PeopleInfo.notificationNameA, object: nil)
    center.post(name: PeopleInfo.notificationNameA, object: nil, userInfo: [PeopleInfo.key: PeopleInfo(name: "jjj", age: 11)])
  }
  
  func testRepresentable3() {
    center.addObserver(self, selector: #selector(_didReceive(notification:)), notificationRepresentableType: AccountInfo.self)
    center.post(AccountInfo(id: 0, name: "czw"))
  }
  
  @objc func didReceive(notification: Notification) {
    guard let peopleInfo = PeopleInfo(notification: notification) else { return }
    dump(peopleInfo)
  }
  
  @objc func _didReceive(notification: Notification) {
    guard let peopleInfo = AccountInfo(notification: notification) else { return }
    dump(peopleInfo)
  }

}
