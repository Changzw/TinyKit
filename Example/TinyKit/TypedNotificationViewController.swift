//
//  TypedNotificationViewController.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

final class TypedNotificationViewController: UIViewController {
  let center = NotificationCenter.default

  override func viewDidLoad() {
    super.viewDidLoad()
    center.addObserver(forName: Notification.Name("PlaygroundPageNeedsIndefiniteExecutionDidChangeNotification"), object: nil, queue: nil, using: { note in
      print(note.object)
      print(note.userInfo)
    })

    center.post(name: Notification.Name("PlaygroundPageNeedsIndefiniteExecutionDidChangeNotification"), object: self, userInfo: ["111": 222])
  }

}
