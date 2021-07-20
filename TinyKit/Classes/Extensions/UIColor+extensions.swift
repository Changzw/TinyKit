//
//  UIColor+extensions.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/7/19.
//

import Foundation

public extension UIColor {
  static var random: UIColor {
    .init(red:    CGFloat(arc4random()%255)/255.0,
          green:  CGFloat(arc4random()%255)/255.0,
          blue:   CGFloat(arc4random()%255)/255.0,
          alpha:  CGFloat(arc4random()%100)/100.0)
  }
}
